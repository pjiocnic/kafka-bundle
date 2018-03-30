# Kafka on Kubernetes MVP

This chart is an [umbrella chart](https://docs.helm.sh/developing_charts/#complex-charts-with-many-dependencies) with subcharts for Kafka, ZooKeeper, a Kafka test client, and the Kafka Manager dashboard.

## Quickstart

Run:

	helm upgrade -i my-release -f config.yaml .

Which is equivalent to:

	helm upgrade --install my-release --values my-values.yaml .

This lets you use the same command for initial install and [idempotent release upgrades](https://github.com/kubernetes/helm/blob/b2ac6d3dd92a4b779423fe6c3d0a24592c5d70cf/docs/charts_tips_and_tricks.md#upgrade-a-release-idempotently).

Teardown:

	helm del my-release

Which is equivalent to:

	helm delete my-release

---

## Kafka & ZooKeeper

In Docker for Mac, set resources available to Docker to at least:

	- CPUs:   4
	- Memory: 8.0 GiB
	- Swap:   1.0 GiB

Setup:

	git clone https://github.com/astronomerio/kafka-k8s.git

	mkdir kafka-k8s && cd kafka-k8s

	helm init

	helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator

Install ZooKeeper:

	helm install --set resources.limits.memory=1Gi --set resources.requests.memory=0.5Gi --name myzk zookeeper

Install Kafka:

	helm install --name my-kafka kafka

	# TODO: override kafka memory settings?

Install Kafka test client:

	kubectl apply -f kafka-tunnel.yaml

Install Kafka Manager

	helm install \
	--set zookeeperHosts="my-kafka-zookeeper:2181" \
	--set applicationSecret="my-secret" \
	--set basicAuth.enabled=true \
	--set basicAuth.username="myuser" \
	--set basicAuth.password="mypass" \
	--name my-kafka-manager kafka-manager

Port forward the Kafka Manager dashboard:

	export POD_NAME=$(kubectl get pods --namespace default -l "app=kafka-manager" -o jsonpath="{.items[0].metadata.name}")

	kubectl port-forward $POD_NAME 8080:9000

Open the Kafka Manager dashboard in your browser:

	open http://127.0.0.1:8080

Install Kubernetes dashboard chart (if needed):

	helm install stable/kubernetes-dashboard

Start Kubernetes dashboard:

	export POD_NAME=$(kubectl get pods -n default -l "app=kubernetes-dashboard,release=dangling-ocelot" -o jsonpath="{.items[0].metadata.name}")
	kubectl -n default port-forward $POD_NAME 8443:8443

Open Kubernetes dashboard

	open https://127.0.0.1:8443/

Check status:

From CLI:

	kubectl get all -l app=zookeeper

Or dashboard:

	open http://127.0.0.1:8001/ui

Create a Kafka topic:

	kubectl -n default exec testclient -- /usr/bin/kafka-topics --zookeeper my-kafka-zookeeper:2181 --topic test1 --create --partitions 1 --replication-factor 1

List Kafka topics:

	kubectl -n default exec testclient -- /usr/bin/kafka-topics --zookeeper my-kafka-zookeeper:2181 --list

Start a consumer to listen to a topic:

	kubectl -n default exec -ti testclient -- /usr/bin/kafka-console-consumer --bootstrap-server my-kafka-kafka:9092 --topic test1 --from-beginning

Start a producer to send messages to a topic:

	kubectl -n default exec -ti testclient -- /usr/bin/kafka-console-producer --broker-list my-kafka-kafka-headless:9092 --topic test1

## Kafka Dashboards

There are a large number of dashboards, and more generally, monitoring tools available for Kafka.  There are several options available for Kafka dashboards to monitor many metrics such as topics, brokers, producers, consumers, messages, clients, partitions, etc.  Additionally, there are ZooKeeper monitoring tools that are useful in the context of Kafka.

Kafka monitoring tools fall into 4 different types of components: transport, storage, processing, and visualization.

Some tools are lightweight niche feature-specific tools; some are collections of tools as dedicated dashboards, like Yahoo Kafka Manager; while others are heavyweight comprehensive platforms, like Confluent or Landoop.

These results are aggregated across searching Google, Stack Overflow, etc from the references listed at the bottom of this section.

### Yahoo Kafka Manager

The [Yahoo Kafka Manager](https://github.com/yahoo/kafka-manager) dashboard provides a popular GUI for managing Kafka clusters.  It does not include a Helm chart or Kubernetes integration out of the box.

There have been several attempts to run it on Kubernetes but there is not yet a stable chart.

- https://github.com/Yolean/kubernetes-kafka/tree/master/yahoo-kafka-manager
- https://github.com/kubernetes/charts/pull/2917
	- https://github.com/oleh-ozimok/charts/tree/kafka-manager
- https://github.com/MacTynow/kafka-manager-chart
- https://github.com/sheepkiller/kafka-manager-docker
- https://github.com/nearform/openshift-kafka

### LinkedIn Kafka Monitor

- https://github.com/linkedin/kafka-monitor

### tulinmola/kafka-dashboards

- https://github.com/tulinmola/kafka-dashboards

### Landoop

#### fast-data-dev

- https://github.com/Landoop/fast-data-dev
- Includes kafka-topics-ui, schema-registry-ui, kafka-connect-ui, etc
- http://www.landoop.com/kafka/kafka-tools/

#### Landoop Lenses (license required)

- http://www.landoop.com/kafka-lenses/
- https://github.com/Landoop/lenses-docker
- http://lenses.stream

### Confluent Control Center (paid)

- https://www.confluent.io/product/control-center/

### Symantec Kafka Monitoring Tool

- https://github.com/Symantec/kafka-monitoring-tool

### Kafka Web Console (deprecated)

- https://github.com/claudemamo/kafka-web-console

### Burrow + Burrow Dashboard

- https://github.com/joway/burrow-dashboard
- https://github.com/linkedin/Burrow

### Apache Zeppelin

- https://zeppelin.apache.org

### Kafka Tool

- http://www.kafkatool.com

### Misc

#### Kafka System Tools

- https://cwiki.apache.org/confluence/display/KAFKA/System+Tools

#### Kafka REST Proxy

- Not a dashboard itself but opens a RESTful interface to the Kafka cluster instead of using the native Kafka protocol and clients.
- https://github.com/confluentinc/kafka-rest
- https://docs.confluent.io/current/kafka-rest/docs/index.html

#### Datadog

- https://www.datadoghq.com/dashboards/kafka-dashboard/
- How to Monitor Kafka Performance Metrics series (3-part)
	- [Part 1 - Monitoring Kafka performance metrics](https://www.datadoghq.com/blog/monitoring-kafka-performance-metrics/)
	- [Part 2 - Collecting Kafka performance metrics](https://www.datadoghq.com/blog/collecting-kafka-performance-metrics/)
	- [Part 3 - Monitoring Kafka with Datadog](https://www.datadoghq.com/blog/monitor-kafka-with-datadog/)

#### kafka-statsd-metrics2

- https://github.com/airbnb/kafka-statsd-metrics2

#### Prometheus / Grafana

##### Kafka Overview

- https://grafana.com/dashboards/721
- https://www.robustperception.io/monitoring-kafka-with-prometheus/

##### kafka_exporter

- https://github.com/danielqsj/kafka_exporter

##### JMX Exporter

- https://github.com/prometheus/jmx_exporter

##### kafka-prometheus-monitoring

- https://github.com/rama-nallamilli/kafka-prometheus-monitoring

### References

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

## ZooKeeper Resources

- Netflix Exhibitor - https://github.com/soabase/exhibitor
- Apache Curator (was Netflix Curator) - http://curator.apache.org
	- https://medium.com/netflix-techblog/introducing-curator-the-netflix-zookeeper-library-c814d3f4917c

## Documentation

- [Apache Kafka](http://kafka.apache.org/documentation/)
- [Confluent](https://docs.confluent.io/current/)
- [ZooKeeper](https://zookeeper.apache.org/doc/current/)
