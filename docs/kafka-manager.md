# Kafka Manager Setup

**Kafka Manager** is the most popular dashboard for managing Kafka clusters.  It was open sourced by Yahoo.

There are 2 options for running Kafka Manager:

1. Using the pre-made Docker image (recommended)
1. Running it manually outside of Docker

## Option 1 - Kafka Manager Docker (recommended)

**Kafka Manager Docker** dockerizes Kafka Manager and its dependencies.

The original source is outdated and no longer maintained — we've forked and updated it at [astronomerio/kafka-manager-docker](https://github.com/astronomerio/kafka-manager-docker).  Note: Ignore the old Docker Compose file in this repo.

### Build

	git clone https://github.com/astronomerio/kafka-manager-docker.git
	cd kafka-manager-docker
	docker build .

## Option 2 - Kafka Manager (manual)

You can also build Kafka Manager manually.

Kafka Manager is built with sbt (Simple Build Tool), an open source Scala build tool similar to Maven for Java.

### Build

	git clone https://github.com/yahoo/kafka-manager.git
	cd kafka-manager
	./sbt clean dist
