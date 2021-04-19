package:
	cd ../../index && \
	helm package ../charts/fullapp

## para testar fora de um container
## helm plugin install https://github.com/quintush/helm-unittest
test:
	docker run -ti --rm -v $(PWD):/apps quintush/helm-unittest -3 .
