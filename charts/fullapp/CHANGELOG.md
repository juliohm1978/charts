# Changelog

## 2021-11-12 1.5.0

* Add support for ipFamilies in Service declaration. Defaults to IPv4 only.

## 2021-09-11 1.4.3

* Fix rendering of Service ports.

## 2021-08-17 1.4.2

* Support additional config in the main container spec - `extraContainerConfig`.
## 2021-08-17 1.4.1

* Support `mountPropagation` on mounted volumes.
## 2021-08-17 1.4.0

* Provide a way to install a release without creating a Service object.
## 2021-08-09 1.3.2

* Translate more messages and comments to English.

## 2021-08-09 1.3.1

* Fix readinessProbe path.

## 2021-07-15 1.3.0

* Change liveness, readiness and startup probes to use the first ingress path as a default. Falls back to the release name, if no ingress paths are defined.

## 2021-05-16 1.0.2

* Add support for Prometheys Operator resources
  - ServiceMonitor
  - PrometheysRule
  - AlertmanagerConfig
* Add support to PVC annotations
* Fix apiVersion on ServiceAccount

## 2021-04-16 1.0.1

* Make startupProbe more dynamic
* Remove unfinished testing
* Remove cifs templates
* Disable idDeploy by default

## 2021-03-10 1.0.0
