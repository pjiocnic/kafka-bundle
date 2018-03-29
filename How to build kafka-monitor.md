# How to build Kafka Monitor

Install build dependencies, create the docker image for [Kafka Monitor](https://github.com/linkedin/kafka-monitor), and push it to your Docker registry.

## Setup

Install system-level build dependencies:

```
brew cask install java
brew install gradle
```

## Step 1: Get the code.

```
git clone https://github.com/linkedin/kafka-monitor.git
cd kafka-monitor
```

## Step 2: Build Kafka Monitor.

```
./gradlew jar
```

## Step 3: Build and push Docker image.

Change `PREFIX` to a registry you can access if needed.

```
export PREFIX=astronomerio/kafka-monitor
cd docker

make container
make push
```
