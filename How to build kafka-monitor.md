# How to build Kafka Monitor

Install Java build dependencies, create the docker image for [Kafka Monitor](https://github.com/linkedin/kafka-monitor), and push it to a repository on your Docker registry.

## Setup

*Note: It [doesn't build successfully](https://stackoverflow.com/questions/46893768/could-not-determine-java-version-from-9-0-1/46994866#46994866) on Java 10 (latest), so we need to install Java 8 instead.*

Install system-level build dependencies:

```
brew tap caskroom/versions
brew cask install java8

brew install gradle
```

## Step 1: Get the code.

```
git clone https://github.com/linkedin/kafka-monitor.git
cd kafka-monitor
```

## Step 2: Build Kafka Monitor.

The Gradle Wrapper script (gradlew) invokes Gradle to build the project.

```
./gradlew jar
```

## Step 3: Build and push Docker image.

Change `PREFIX` to a repository you have access to if needed.

```
export PREFIX=astronomerio/kafka-monitor
cd docker

make container
make push
```

This should produce the Docker image tagged `astronomerio/kafka-monitor:0.1`.
