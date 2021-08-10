# Changelog

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
