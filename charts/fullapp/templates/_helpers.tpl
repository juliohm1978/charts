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
