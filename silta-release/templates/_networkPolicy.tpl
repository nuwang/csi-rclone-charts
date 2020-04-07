
{{ define "silta-release.networkPolicy" }}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: {{ .Release.Name }}-{{ .id }}
  labels:
    release: {{ .Release.Name }}
spec:
  podSelector:
    matchLabels:
      release: {{ .Release.Name }}
{{- if .additionalPodSelectors -}}
      {{ .additionalPodSelectors | toYaml | nindent 6}}
{{- end }}
  policyTypes:
  - Ingress
  ingress:
  - from:
    {{ if .from -}}
    {{ .from | toYaml | nindent 4 }}
    {{ else }}
    - namespaceSelector:
        matchLabels:
          name: {{ .Release.Namespace }}
    {{ end }}
{{ end }}