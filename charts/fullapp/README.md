# General purpose chart for simple applications

This helm chart is meant to give you way to deploy simple applications that do not deman much complexity. As long as you have simple requirements, most configurations for the common k8s resources are supported:

* Deployment / StatefulSet / DaemonSet
* Service
* Ingress
* Volumes

The chart assumes your Pod template runs one main container, which is tied to a single Service. Optionally, it can also create multiple ingresses and volumes.

## Minimal required values

Make sure you have the repository added to your helm installation.

```
helm repo add juliohm1978 https://raw.githubusercontent.com/juliohm1978/charts/master/index
```

Initial setup for this chart is quite simple. For the most part, only a few values are truly required:

| values.yaml      | Description                                                                                |
|------------------|--------------------------------------------------------------------------------------------|
| pod.image        | Name of the image that will be used as the main container. Format: `repository/image-name` |
| pod.tag          | Tag of the image that will be used as the main container.                                  |
| service.ports[0] | At last one port must be defined in the `service` key.                                     |

This should be enough to get a Deployment running with 1 replica.

Optionally, you can also define `pod.digest`, which will be appended to the container image. In that case, the final image name used will become:

```
{{.Values.pod.image}}:{{.Values.pod.tag}}@{{.Values.pod.digest}}
```

The default `values.yaml` in this chart is full of comments and examples, so this README will provide an overview of the assumptions it makes, followed by some exmaples.

## Pod template and Service

The chart assumes the first container to be its *main container*. It will create one Service, which is closely tied together. The ports declared in the Service will be mapped to the main container.

The Service itself and its first port are also considered defaults for Ingress objects, as well as the ports used in the `readinessProbe`, `livenessProbe` and `startupProbe`.

## Deployment kind

The `deployment.kind` key supports any of:

* Deployment
* StatefulSet
* DaemonSet

Each one will demand adjustments to the `deployment.strategy` accordingly, and you will find examples in the comments.

## Force pod restarts with `idDeploy`

You can use the flag `pod.enableIdDeploy` to create a label called `idDeploy` in the Pod template. The value is a random UUID that changes everytime you run `helm upgrade` on the same release. In practice, this forces the Pod to restart with a new rollout. If you need to use `latest` or a fixed tag and still need to keep the image updated in the cluster, you can combine `enableIdDeploy` with `imagePullPolicy: Always`.

**NOTE**: Be aware, this is not considered a good practice. Consider using `pod.digest`, which allows you to keep `imagePullPolicy: IfNotPresent`. The chart, however, will not calculate the image digest. This value needs to be calculated before hand and passed as an argument to the release.

## Init containers and extra containers

It is possible to define `initContainer` with the `pod.initContainers[]` list and additional containers in the Pod with `pod.extraContainers[]`. The contents of each item follow the same spec for the Containers API:

https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.21/#container-v1-core

**NOTE**: It is important to realize that additional containers will not have ports and volumes automatically mapped to them. You will need to define the entire spec yourself.

## Ingresses

You can define one or more Ingresses for your application using the `ingresses.paths[]` list. For simplicity of implementation, each path will become an individual Ingress object. You can change the port the ingress points to by defining `ingresses.paths[].servicePort`, but all Ingresses will point to the same Service created by the chart. 

Some defaults for all Ingresses can be defined with:

```yaml
ingresses:
  annnotations:
    ### some annotations for all ingresses

  domain: example.com
  tlsSecretname: certificate-tls
```

These values will be replicated to all Ingresses created with the list `ingresses.paths[]`. Besides that, each Ingress created from a path can also define its own additional annotations and ovewrite the values for `domain` and `tlsSecretName`.

## Volumes

This chart supports mounting volumes in a variety of ways. You can use PVCs, PVs, ConfigMaps and even external resources not managed by this chart.

### ConfigMap Volume

The `configMaps[]` list can be used to define ConfigMaps that will be mounted as volumes into the Pod's main container.

A simple example would be:

```yaml
configMaps:
  - name: configmap1
    mountPath: /path/inside/container
    my-config-map:
      file1.txt: |
        Contents of the
        file1
      file2.txt: |
        Contents of the
        file2
```

Keep in mind that `/path/inside/container` will be fully replaced with the contents of the ConfigMap. If you wish to replace only the filenames declared, you can set `mountSubPath: true`.

```yaml
configMaps:
  - name: configmap1
    mountPath: /path/inside/container
    mountSubPath: true
    my-config-map:
      file1.txt: |
        Contents of the
        file1
      file2.txt: |
        Contents of the
        file2
```

This causes the chart to render a different volumeMount for each item in the ConfigMap, keeping the other files in `/path/inside/container` intact when the Pod is created

If you do not provide a `mountPath`, the ConfigMap will simply be created, but not mounted in the Pod.

```yaml
configMaps:
  - name: configmap1
    my-config-map:
      file1.txt: |
        Contents of the
        file1
      file2.txt: |
        Contents of the
        file2
```

## PersistentVolumeClaims

The `persistentVolumeClaims[]` list can be used to declare PVCs that will be mounted in the Pod's main container.

```yaml
persistentVolumeClaims:
  - name: www
    readOnly: false
    mountPath: /path/inside/container
    spec:
      accessModes: [ "ReadWriteOnce" ]
      storageClassName: "my-storage-class"
      resources:
        requests:
          storage: 1Gi
```

Whatever PVC definition you need can be written under `persistentVolumeClaims[].spec`. In common sense, the PV will not be provisioned by the chart. You should either do it manually, or use `storageClassName` to delegate that task to an external provisioner.

## Direct Volume

In some cases, you may not need or wish to create a PVC, but instead, mount PVs directly into the Pod. You can declare them in the `volumes[]` list, giving it a name and a `spec` body.

```yaml
volumes: []
  - name: myvolume
    mountPath: /path/inside/container
    spec:
      nfs:
        server: 123.123.123.123
        path: /NFS_server/share
```

This gives you the flexibility to mount any volume type supported by Kubernetes, using drivers such as NFS, flex volumes, Secrets or even ConfigMaps not managed by this chart.

```yaml
extraVolumeMounts: []
  - mountPath: /etc/config/file
    name: config-map
    subPath: file
```

## Network Policies

NetworkPolicies can be declared in the `networkPolicies[]` list. Each item follows the spec from the standar NetworkPolicy resource, and several examples can be found in the comments.

Label selectors will be automatically generated so that policies will be tied to the pods running from this chart.

## Prometheus Operator

Metrics collection can be configured if a Prometheus instance deployed by Prometheus Operator. In order to use this section of the chart, Prometheus Operator must be installed.

https://github.com/prometheus-operator/kube-prometheus

With the operator in place, basic metrics such as CPU, memory, IO are already available with provided dashboards and default alerts.

If you need to scrape further endpoints for customized metrics, you can use the `prometheusOperator` to define ServiceMonitors, AlertmanagerConfig and PrometheusRules resources.

### Scrapping custom endpoints

If your application provides custom metrics, beyond the basic container values (cpu, memory, io, etc.), you can define ServiceMonitors to collect on specific endpoints. You can use the `serviceMonitors` list to define them.

```yaml
  serviceMonitors:
    - name: mymetrics
      endpoints:
        - targetPort: 9404
          path: /metrics
          scheme: http
          params: {}
          interval: 30s
          scrapeTimeout: 15s
```

The `endpoints[]` list follows the spec from the ServiceMonitor API, so you can use whatever values are defined there.

https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#endpoint

ServiceMonitors created by the chart will automatically receive label selectors that restrict the collection the pods of your application.

**NOTE**: It is important to remember that ports used in the endpoints MUST be declared in the Pod. For this chart, that means they have to be declared in the `service` key.

### Custom Alert Rules

You can control the creation of alert rules.

```yaml
prometheusOperator:
  rules:
    - alert: ImportantMetricAlert
      expr: |
        count(kube_deployment_created) < 0
      annotations:
        summary: Ooops. Something's wrong.
        description: "Instructions on how to proceed here."
```

Each item in the list will become a PrometheusRule resource.

### Receivers for alerts

You can also define AlertManager receivers to route alerts fired by your custom rules.

```yaml
prometheusOperator:
    receivers:
      - name: email
        emailConfigs:
        - to: 'email@example.com'
          sendResolved: true
          html: '{{ template "email.body.html" . }}'
          headers:
            - key: Subject
              value: '{{ template "email.subject.html" . }}'
```

Check the receiver API to understand what you can use to configure it.

https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/api.md#receiver

### Routing alerts

Notice that the examples above did not have a route defined, while AlertManager needs them to route the alerts. This chart will minimize your configuration by creating a default route automatically. Without any furhter customization, every alert will routed to the first receiver in the `receivers[]` list.

If you have more than one receiver defined, the first one will be considered a default for all the alerts. You route a specifit alert to another receiver by including a label:

```yaml
prometheusOperator:
  rules:
    - alert: ImportantMetricAlert
      expr: |
        count(kube_deployment_created) < 0
      annotations:
        summary: Ooops. Something's wrong.
        description: "Instructions on how to proceed here."
      labels:
        ## this receiver should be declared in the `receivers[]` list
        receiver: discordbot
```

In fact, every receiver on the list will have a route dedicated for it, selecting alerts by the label `receiver`.

### Advanced custom routes

If you really need more complicated routing rules, you can define your own using the `route` key.

```yaml
  route:
    ## Change the default receiver, if you don't want it to be the
    ## first one of your list.
    receiver: another-default-receiver

    ## Customize intervals. If not defined, the global values defined
    ## in your Alertamanger will be used.
    groupBy: ["alertname"]
    groupWait: 30s
    groupInterval: 10s
    repeatInterval: 1m
    
    ## Define sub-routes, only if you need more advanced routing rules
    ## based on your own custom labels.
    routes:
      - matchers:
          - name: category
            value: warning
        receiver: discordbot
        groupBy: ["alertname"]
        groupWait: 30s
        groupInterval: 10s
        repeatInterval: 1m
```
