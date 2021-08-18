{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "fullapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fullapp.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "fullapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Tenta deduzir o serviceAccount name para o Pod.
Quando não definido em .Values.pod.serviceAccount.name, utiliza default
*/}}
{{- define "serviceaccount-name" -}}
{{-  .Values.pod.serviceAccount.name | default "default" | printf "%s" -}}
{{- end -}}

{{- define "fullapp.fullimagename" -}}
  {{- $imagedigest := (empty .Values.pod.digest) | ternary "" (printf "%s%s" "@" .Values.pod.digest) -}}
  {{- printf "%s:%s%s" .Values.pod.image .Values.pod.tag $imagedigest -}}
{{- end -}}

{{/*
Returns the first port of the Service defined in values.yaml.
If the Service is disabled, returns an empty value.
*/}}
{{- define "fullapp.serviceFirstPort" -}}
  {{- if and (.Values.service.enabled) (not (empty .Values.service.ports)) -}}
    {{- (index .Values.service.ports 0).port -}}
  {{- else -}}
    {{- "" -}}
  {{- end -}}
{{- end -}}

{{/*
Returns the name of the first port of the Service defined in values.yaml.
If the Service is disabled, returns an empty value.
*/}}
{{- define "fullapp.serviceFirstPortName" -}}
  {{- if and (.Values.service.enabled) (not (empty .Values.service.ports)) -}}
    {{- (index .Values.service.ports 0).name -}}
  {{- else -}}
    {{- "" -}}
  {{- end -}}
{{- end -}}

{{/*
Used to determine the port used in readinessProbe/livenessProbe/startupProbe.
If the probe is disabled, returns an empty value.
*/}}
{{- define "fullapp.probePortValue" -}}
  {{- if and .enabled .port -}}
    {{- .port -}}
  {{- else -}}
    {{- "" -}}
  {{- end -}}
{{- end -}}
