# Kafka on Kubernetes MVP

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

Install Kubernetes dashboard (if needed):

	kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

Start Kubernetes dashboard:

	kubectl proxy

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
