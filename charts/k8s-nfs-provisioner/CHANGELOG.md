# CHANGELOG

## 2020-01-23 1.2.5

* Move `terminationGracePeriodSeconds` to the correct location, inside Pod spec.

## 2020-01-23 1.2.4

* Change field `terminationGracePeriod` to `terminationGracePeriodSeconds`.

## 2019-05-27 1.2.3

* Remove `nfsVersion` from `values.yaml`.
* Bump app version to 1.2.3.

## 2019-05-26 1.2.2

* Bump app version to 1.2.2

## 2019-05-23 1.2.0

* Sync chart major versions with application version.
* Provide way do declare storage classes in values.yaml so they can be mounted in to the Pod.

## 2019-05-23 1.0.2, 1.0.3

* Add nfsVersion argument to the command line.

## 2019-05-23 1.0.1

* Add permissions to update/patch PVC status.

## 2019-05-22 1.0.0

* First chart: k8s-nfs-provisioner
