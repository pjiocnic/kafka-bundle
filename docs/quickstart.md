# Kafka Bundle Quickstart

Run:

	helm upgrade -i my-release -f config.yaml .

(Equivalent to: `helm upgrade --install my-release --values config.yaml .`)

This lets you use the same command for initial install and [idempotent release upgrades](https://github.com/kubernetes/helm/blob/b2ac6d3dd92a4b779423fe6c3d0a24592c5d70cf/docs/charts_tips_and_tricks.md#upgrade-a-release-idempotently).

Teardown:

	helm del my-release

(Equivalent to: `helm delete my-release`)
