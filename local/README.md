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
$ docker run --network host \
      --rm apache/kafka:latest /opt/kafka/bin/kafka-topics.sh \
      --bootstrap-server localhost:9092 \
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
$ docker run -it --network host \
      --rm apache/kafka:latest /opt/kafka/bin/kafka-console-producer.sh \
      --bootstrap-server localhost:9092 \
      --topic sample.v1.avro

$ docker run --network host \
      --rm apache/kafka:latest /opt/kafka/bin/kafka-console-consumer.sh \
      --bootstrap-server localhost:9092 \
      --topic sample.v1.avro \
      --group demo \
      --from-beginning

$ docker run -it --network host \
      --rm apache/kafka:latest /opt/kafka/bin/kafka-producer-perf-test.sh \
      --producer-props bootstrap.servers=localhost:9092 \
      --topic sample.v1.avro --num-records 1000 --throughput 5 --record-size 10240
```

Create connector
```shell
curl localhost:8083/connectors
```