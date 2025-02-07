Explain how to test the kafka environment in SSL mode :

- create topic
  - create schema
  - produce and consume message
  - create connector (debezium, filepulse, s3, mm2, echosink)

```shell
$ docker compose up -d
$ docker compose down -v
```

Test keycloak
```shell
curl --url http://keycloak:8080/realms/kafka-authbearer/.well-known/openid-configuration | jq .
curl --url http://keycloak:8080/realms/kafka-authbearer/protocol/openid-connect/certs | jq .

openssl rsa -pubin -in keypair/public.pem -text

curl --request POST \
  --url http://keycloak:8080/realms/kafka-authbearer/protocol/openid-connect/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'grant_type=client_credentials' \
  --data-urlencode 'client_id=kafka_client' \
  --data-urlencode 'client_secret=kafka_client_secret' \
  --data-urlencode 'scope=profile' \
  | jq .

export TOKEN=$(curl -s \
-d "client_id=kafka_client" \
-d "client_secret=kafka_client_secret" \
-d "grant_type=client_credentials" \
http://keycloak:8080/realms/kafka-authbearer/protocol/openid-connect/token | jq -r .access_token)

echo $TOKEN
```

Test MDS
```shell
http://localhost:8091/security/openapi/swagger-ui/index.html

curl -X GET "http://broker1:8091/kafka/v3/clusters" -H "accept: application/json" -H "Authorization: Bearer $TOKEN"
curl -X POST "http://broker1:8091/kafka/v3/clusters/MkU3OEVBNTcwNTJENDM2Qk/topics" -H "accept: application/json" -H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -d '
{
    "topic_name": "topic-X",
    "partitions_count": 1,
    "replication_factor": 1
}'

curl -X GET "http://broker1:8091/security/1.0/authenticate" -H "accept: application/json" -H "Authorization: Bearer $TOKEN" | jq .
curl -X GET "http://broker1:8091/security/1.0/lookup/rolebindings/principal/User:kafka_client" -H "accept: application/json" -H "Authorization: Bearer $TOKEN" | jq .
curl -X GET "http://broker1:8091/security/1.0/roles" -H "accept: application/json" -H "Authorization: Bearer $TOKEN" | jq .
```

Create topic
```shell
$ kafka-topics --command-config client.properties --bootstrap-server localhost:9092 --topic sample.v1.avro --create
```

Produce and consume messages
```shell
$ kafka-console-producer --producer.config client.properties --bootstrap-server localhost:9092 --topic sample.v1.avro

$ kafka-console-consumer --consumer.config client.properties --bootstrap-server localhost:9092 --topic sample.v1.avro --group demo --from-beginning

$ kafka-producer-perf-test --producer.config client.properties --topic sample.v1.avro --num-records 1000 --throughput 5 --record-size 10240 

$ kafka-consumer-perf-test --consumer.config client.properties  --bootstrap-server localhost:9092 --topic sample.v1.avro --group demo-perf --messages 1000 --print-metrics --reporting-interval 10000 --show-detailed-stats
```

Subject and connector
```shell
curl -H "Authorization: Bearer $TOKEN" http://localhost:8081/schemas/types

jq '. | {schema: tojson}' ../../assets/schema/demo.avsc | \
  curl -X POST http://localhost:8081/subjects/sample.v1.avro-value/versions \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type:application/json" \
  -d @-

curl -H "Authorization: Bearer $TOKEN" http://localhost:8083/connector-plugins/ | jq .
```

