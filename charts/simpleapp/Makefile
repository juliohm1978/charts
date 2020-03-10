package:
	cd ../../index && \
	helm package ../charts/simpleapp

index: package
	cd ../../index && \
	make

template:
	rm -fr template-output
	helm template TESTING . --output-dir template-output
