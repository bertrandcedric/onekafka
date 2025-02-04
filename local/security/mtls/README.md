Explain how to test the kafka environment in SSL mode :

- create topic
  - create schema
  - produce and consume message
  - create connector (debezium, filepulse, s3, mm2, echosink)

```shell
$ docker compose up -d
$ docker compose down -v
```

Create topic
```shell
$ kafka-topics.sh --command-config client.properties --bootstrap-server localhost:9092 --topic sample.v1.avro --create
```

Create subject
```shell
curl --cacert ../certificates/schema-registry-ca1-signed.crt \
  --cert-type P12 --cert ../certificates/schema-registry.keystore.p12:confluent \
  https://localhost:8081

jq '. | {schema: tojson}' ../../assets/schema/demo.avsc | \
  curl --cacert ../certificates/schema-registry-ca1-signed.crt \
  --cert-type P12 --cert ../certificates/schema-registry.keystore.p12:confluent \
  -X POST https://localhost:8081/subjects/sample.v1.avro-value/versions \
  -H "Content-Type:application/json" \
  -d @-
```

Produce and consume messages
```shell
$ kafka-console-producer.sh --producer.config client.properties --bootstrap-server localhost:9092 --topic sample.v1.avro

$ kafka-console-consumer.sh --consumer.config client.properties --bootstrap-server localhost:9092 --topic sample.v1.avro --group demo --from-beginning

$ kafka-producer-perf-test.sh --producer.config client.properties --topic sample.v1.avro --num-records 1000 --throughput 5 --record-size 10240

$ kafka-consumer-perf-test.sh --consumer.config client.properties  --bootstrap-server localhost:9092 --topic sample.v1.avro --group demo-perf --messages 1000 --print-metrics --reporting-interval 10000 --show-detailed-stats
```