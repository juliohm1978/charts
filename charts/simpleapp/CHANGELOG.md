# CHANGELOG

## 2020-02-26 1.1.16

* Adiciona suporte ao `hostNetwork` e `dnsPolicy`.

## 2020-02-22 1.1.15

* Ajusta valores dos probes para ser mais agressivo.

## 2020-01-28 1.1.14

* Remove valor default do `externalTrafficPolicy`, que só pode ser definido com o tipo `LoadBalancer`.

## 2020-01-25 1.1.13

* Adiciona suporte ao `loadBalancerIP`.

## 2020-01-25 1.1.12

* Adiciona suporte ao `serviceAnnotations`.

## 2020-01-25 1.1.11

* Desfaz alterações da 1.1.10. Não funciona.

## 2020-01-25 1.1.10

* Usa `loadBalancerExternalIPs` no campo `status` do Service para configurar o IP externo manualmente.

## 2020-01-25 1.1.9

* Adiciona campo `externalTrafficPolicy` no Service.

## 2019-12-22 1.1.8

* Adiciona serviceAccount na descrição do Pod.
* Adiciona deploymentType: Deployment/DaemonSet/StatefulSet

## 2019-12-01 1.1.7

* Não muda nada.

## 2019-11-16 1.1.6

* Corrige lugar do label idDeploy

## 2019-11-16 1.1.5

* Inclui suporte ao label idDeploy para forçar restart em cada deploy.

## 2019-11-16 1.1.4

* Corrige erro que aparecia no helm3 - coalesce.go:196: warning: cannot overwrite table with non table for pullSecrets (map[])

## 2019-11-16 1.1.3

* Modifica parâmetros do RollingUpdate para não maxUnavailable=0

## 2019-10-05 1.1.2

* Corrige erro de renderização do Deployment quando values possui 'filesystem' e não possui 'persistence'.

## 2019-10-05 1.1.1

* Adiciona labels mais detalhados.

## 2019-10-05 1.1.0

* Atualiza apiVersion nos objetos para usar API mais recente, remove antigas como v1beta1.

## 2019-09-10 1.0.11

* Aumenta período dos probes para ser menos agressivo.

## 2019-08-31 1.0.10

* Adiciona labels e annotations no pod template do Deployment.

## 2019-08-16 1.0.9

* Corrige renderização do deployment strategy para poder usar o tipo Recreate.

## 2019-05-26

Migrated from local repository.
