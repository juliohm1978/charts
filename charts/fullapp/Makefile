package:
	cd ../../index && \
	helm package ../charts/fullapp

## para testar fora de um container
## helm plugin install https://github.com/quintush/helm-unittest
# test:
# 	docker run -ti --rm -v $(PWD):/apps quintush/helm-unittest -3 .

output:
	rm -fr output_yaml
	helm template . -f values-test.yaml --namespace MYNAMESPACE --output-dir output_yaml

install:
	helm upgrade --create-namespace --install test . -f values-test.yaml -n test

delete:
	helm delete test -n test
