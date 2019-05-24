# Kubernetes NFS Volume Provisioner

## TODO

* render storageclass objects

## Description

A somewhat flexible Kubernetes controller that can provision NFS Persistent Volumes in a consistent and predictable way. It relies on the `kubectl` binary as a robust API client to watch for PersistentVolumeClaim events and react in order to provision PersistentVolumes accordingly.

Please, refer to the repository for this project for more details:

<https://github.com/juliohm1978/kubernetes-nfs-volume-provisioner>
