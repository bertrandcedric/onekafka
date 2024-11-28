Explain how to test the kafka environment :

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
$ docker run --network kafka_kafka-platform \
      --rm apache/kafka:latest /opt/kafka/bin/kafka-topics.sh \
      --bootstrap-server kafka:29092 \
      --topic sample.v1.avro \
      --create
```

Create schema
```shell
$ jq '. | {schema: tojson}' schema/demo.avsc | \
    curl -X POST http://localhost:8081/subjects/sample.v1.avro-value/versions \
         -H "Content-Type:application/json" \
         -d @-
```

Produce and consume messages
```shell
$ docker run -it --network kafka_kafka-platform \
      --rm apache/kafka:latest /opt/kafka/bin/kafka-console-producer.sh \
      --bootstrap-server kafka:29092 \
      --topic sample.v1.avro

$ docker run --network kafka_kafka-platform \
      --rm apache/kafka:latest /opt/kafka/bin/kafka-console-consumer.sh \
      --bootstrap-server kafka:29092 \
      --topic sample.v1.avro \
      --group demo \
      --from-beginning
```
