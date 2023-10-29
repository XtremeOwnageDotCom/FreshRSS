{{/*
Generate a name based on the release name and chart name.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Release.Name -}}
{{- end -}}

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
app.kubernetes.io/name: {{ template "name" . }}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | default "" }}
{{- with .Values.extraLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}