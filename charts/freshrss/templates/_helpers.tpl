{{/*
Generate a name based on the release name and chart name.
*/}}

{{- define "freshrss.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "freshrss.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts
*/}}
{{- define "freshrss.namespace" -}}
{{- if .Values.namespaceOverride }}
{{- .Values.namespaceOverride }}
{{- else }}
{{- .Release.Namespace }}
{{- end }}
{{- end }}


# Data PVC name.
{{- define "freshrss.dataPVC" -}}
{{- if .Values.persistence.existingPVCName }}
{{- .Values.persistence.existingPVCName }}
{{- else }}
{{- .Release.Name }}-data
{{- end }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "freshrss.labels" -}}
app.kubernetes.io/name: {{ template "freshrss.name" . }}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | default "" }}
{{- with .Values.extraLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "freshrss.selectorLabels" -}}
app.kubernetes.io/name: {{ include "freshrss.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}