rn=my-release
kmp=charts/kafka-monitor

# install kafka bundle
.PHONY: install-kb
install-kb:
	helm install --name ${rn} -f config.yaml .
	helm list

# upgrade kafka bundle
.PHONY: upgrade-kb
upgrade-kb:
	helm upgrade ${rn} -f config.yaml .
	helm list

# install kafka-monitor
.PHONY: install
install:
	# helm upgrade -i my-release -f config.yaml .
	# helm install --name ${rn} -f config.yaml ${kmp}
	helm install --name ${rn} ${kmp}
	helm list

# debug install kafka-monitor
.PHONY: install-debug
install-debug:
	helm install ${kmp} --dry-run --debug

.PHONY: logs
logs:
	# TODO: get matching pod not just first one
	kubectl logs $$(kubectl get pods -o jsonpath='{.items[0].metadata.name}')

.PHONY: bash
bash:
	# TODO: get matching pod not just first one
	# kubectl exec $(kubectl get pods | awk '/kafka-monitor/ {print $1}') -it -- bash
	kubectl exec $$(kubectl get pods -o jsonpath='{.items[0].metadata.name}') -it -- bash

.PHONY: delete
delete:
	helm delete --purge ${rn}
	helm list

.PHONY: reinstall
reinstall: delete install

.PHONY: test-lint
test-lint:
	helm lint ${kmp}

.PHONY: test-unit
test-unit:
	echo "TODO test-unit"

.PHONY: test
test: test-lint test-unit
