Kafka on Kubernetes MVP
=======================

In Docker for Mac, set resources available to Docker to at least:

	- CPUs:   4
	- Memory: 8.0 GiB
	- Swap:   1.0 GiB

Setup:

	mkdir kafka-k8s && cd kafka-k8s

	helm init

	helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator

Install ZooKeeper:

	helm install --set resources.limits.memory=1Gi --set resources.requests.memory=0.5Gi --name myzk incubator/zookeeper

Install Kafka:

	helm install --name my-kafka incubator/kafka

	# TODO: override kafka memory settings?

Install Kafka test client:

	kubectl apply -f kafka-tunnel.yaml

	kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
	kubectl proxy

Check status:

From CLI:

	kubectl get all -l app=zookeeper

Or dashboard:

	open http://127.0.0.1:8001/ui

TODO: add kafka commands
