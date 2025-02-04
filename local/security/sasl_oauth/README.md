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

curl --request POST \
  --url http://keycloak:8080/realms/kafka-authbearer/protocol/openid-connect/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  --data-urlencode 'grant_type=client_credentials' \
  --data-urlencode 'client_id=kafka_client' \
  --data-urlencode 'client_secret=kafka_client_secret' \
  --data-urlencode 'scope=profile' \
  | jq .
```

Create topic
```shell
$ kafka-topics.sh --command-config client.properties --bootstrap-server localhost:9092 --topic sample.v1.avro --create
```

Produce and consume messages
```shell
$ kafka-console-producer.sh --producer.config client.properties --bootstrap-server localhost:9092 --topic sample.v1.avro

$ kafka-console-consumer.sh --consumer.config client.properties --bootstrap-server localhost:9092 --topic sample.v1.avro --group demo --from-beginning

$ kafka-producer-perf-test.sh --producer.config client.properties --topic sample.v1.avro --num-records 1000 --throughput 5 --record-size 10240 

$ kafka-consumer-perf-test.sh --consumer.config client.properties  --bootstrap-server localhost:9092 --topic sample.v1.avro --group demo-perf --messages 1000 --print-metrics --reporting-interval 10000 --show-detailed-stats
```

Subject and connector
```shell
export TOKEN=$(curl -s \
-d "client_id=kafka_client" \
-d "client_secret=kafka_client_secret" \
-d "grant_type=client_credentials" \
http://keycloak:8080/realms/kafka-authbearer/protocol/openid-connect/token | jq -r .access_token)

echo $TOKEN

curl -H "Authorization: Bearer $TOKEN" http://localhost:8081/schemas/types

jq '. | {schema: tojson}' ../../assets/schema/demo.avsc | \
  curl -X POST http://localhost:8081/subjects/sample.v1.avro-value/versions \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type:application/json" \
  -d @-

curl -H "Authorization: Bearer $TOKEN" http://localhost:8083/connector-plugins/ | jq .
```

