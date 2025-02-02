{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "sscdpa.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sscdpa.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Standard labels for helm resources
*/}}
{{- define "sscdpa.labels" -}}
labels:
  app.kubernetes.io/instance: "{{ .Release.Name }}"
  app.kubernetes.io/managed-by: "{{ .Release.Service }}"
  app.kubernetes.io/name: "{{ template "sscdpa.name" . }}"
  app.kubernetes.io/version: "{{ .Chart.AppVersion }}"
  app: {{ template "sscdpa.name" . }}
  helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
{{- end -}}

{{/*
Name of the service account to use
*/}}
{{- define "sscdpa.serviceAccountName" -}}
    {{ default (include "sscdpa.fullname" .) .Values.rbac.serviceAccount.name }}
{{- end -}}

{{/*
Name of the pod security policy to use
*/}}
{{- define "sscdpa.psp.fullname" -}}
{{- printf "%s-psp" (include "sscdpa.fullname" .) -}}
{{- end }}
