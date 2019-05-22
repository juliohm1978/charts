index: k8s-nfs-provisioner
	cd index && \
	helm repo index . && \
	cd .. && \
	git add . && git commit -m "Charts indexed"  && git push

k8s-nfs-provisioner:
	cd index && \
	helm package ../charts/k8s-nfs-provisioner
