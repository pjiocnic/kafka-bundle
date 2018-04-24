# Kafka & ZooKeeper Setup

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
