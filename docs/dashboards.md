# Kafka Dashboards

There are a large number of dashboards, and more generally, monitoring tools available for Kafka.  There are several options available for Kafka dashboards to monitor many metrics such as topics, brokers, producers, consumers, messages, clients, partitions, etc.  Additionally, there are ZooKeeper monitoring tools that are useful in the context of Kafka.

Kafka monitoring tools fall into 4 different types of components: transport, storage, processing, and visualization.

Some tools are lightweight niche feature-specific tools; some are collections of tools as dedicated dashboards, like Yahoo Kafka Manager; while others are heavyweight comprehensive platforms, like Confluent or Landoop.

These results are aggregated across searching Google, Stack Overflow, etc from the references listed at the bottom of this section.

## Yahoo Kafka Manager

The [Yahoo Kafka Manager](https://github.com/yahoo/kafka-manager) dashboard provides a popular GUI for managing Kafka clusters.  It does not include a Helm chart or Kubernetes integration out of the box.

There have been several attempts to run it on Kubernetes but there is not yet a stable chart.

- https://github.com/Yolean/kubernetes-kafka/tree/master/yahoo-kafka-manager
- https://github.com/kubernetes/charts/pull/2917
	- https://github.com/oleh-ozimok/charts/tree/kafka-manager
- https://github.com/MacTynow/kafka-manager-chart
- https://github.com/sheepkiller/kafka-manager-docker
- https://github.com/nearform/openshift-kafka

## LinkedIn Kafka Monitor

- https://github.com/linkedin/kafka-monitor

## tulinmola/kafka-dashboards

- https://github.com/tulinmola/kafka-dashboards

## Landoop

### fast-data-dev

- https://github.com/Landoop/fast-data-dev
- Includes kafka-topics-ui, schema-registry-ui, kafka-connect-ui, etc
- http://www.landoop.com/kafka/kafka-tools/

### Landoop Lenses (license required)

- http://www.landoop.com/kafka-lenses/
- https://github.com/Landoop/lenses-docker
- http://lenses.stream

## Confluent Control Center (paid)

- https://www.confluent.io/product/control-center/

## Symantec Kafka Monitoring Tool

- https://github.com/Symantec/kafka-monitoring-tool

## Kafka Web Console (deprecated)

- https://github.com/claudemamo/kafka-web-console

## Burrow + Burrow Dashboard

- https://github.com/joway/burrow-dashboard
- https://github.com/linkedin/Burrow

## Apache Zeppelin

- https://zeppelin.apache.org

## Kafka Tool

- http://www.kafkatool.com

## Misc

### Kafka System Tools

- https://cwiki.apache.org/confluence/display/KAFKA/System+Tools

### Kafka REST Proxy

- Not a dashboard itself but opens a RESTful interface to the Kafka cluster instead of using the native Kafka protocol and clients.
- https://github.com/confluentinc/kafka-rest
- https://docs.confluent.io/current/kafka-rest/docs/index.html

### Datadog

- https://www.datadoghq.com/dashboards/kafka-dashboard/
- How to Monitor Kafka Performance Metrics series (3-part)
	- [Part 1 - Monitoring Kafka performance metrics](https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/)
	- [Part 2 - Collecting Kafka performance metrics](https://www.datadoghq.com/blog/collecting-kafka-performance-metrics/)
	- [Part 3 - Monitoring Kafka with Datadog](https://www.datadoghq.com/blog/monitor-kafka-with-datadog/)

### kafka-statsd-metrics2

- https://github.com/airbnb/kafka-statsd-metrics2

### Prometheus / Grafana

#### Kafka Overview

- https://grafana.com/dashboards/721
- https://www.robustperception.io/monitoring-kafka-with-prometheus/

#### kafka_exporter

- https://github.com/danielqsj/kafka_exporter

#### JMX Exporter

- https://github.com/prometheus/jmx_exporter

#### kafka-prometheus-monitoring

- https://github.com/rama-nallamilli/kafka-prometheus-monitoring

## References

- https://www.quora.com/What-are-the-user-interfaces-to-browse-Kafka-topics
- https://stackoverflow.com/questions/49043596/kafka-monitoring-tool-in-production
- https://stackoverflow.com/questions/39861823/ui-tool-for-monitoring-kafka
- https://stackoverflow.com/questions/39015920/basic-kafka-topic-availability-checker
- https://stackoverflow.com/questions/49276785/monitoring-ui-for-apache-kafka-kafka-manager-vs-kafka-monitor
- https://stackoverflow.com/questions/29113009/monitoring-kafka-in-python
- https://stackoverflow.com/questions/45312437/real-time-dash-board-for-kafka
- https://stackoverflow.com/questions/42629848/apache-kafka-consumer-analytics-platform-visualize-data
- https://stackoverflow.com/search?q=kafka+dashboard
- https://www.confluent.io/blog/blog-post-on-monitoring-an-apache-kafka-deployment-to-end-most-blog-posts
- https://www.nearform.com/blog/benchmarking-apache-kafka-deployed-on-openshift-with-helm/
