# Define the paths to Prometheus and Grafana executables
$prometheusPath = "C:\path\to\prometheus.exe"
$grafanaPath = "C:\path\to\grafana-server.exe"

# Define service names
$prometheusServiceName = "PrometheusService"
$grafanaServiceName = "GrafanaService"

# Install Prometheus and Grafana as services using NSSM
& "C:\path\to\nssm.exe" install $prometheusServiceName $prometheusPath "--config.file=C:\path\to\prometheus.yml"
& "C:\path\to\nssm.exe" set $prometheusServiceName DisplayName "Prometheus"
& "C:\path\to\nssm.exe" set $prometheusServiceName Description "Prometheus Monitoring Service"
& "C:\path\to\nssm.exe" install $grafanaServiceName $grafanaPath "web"
& "C:\path\to\nssm.exe" set $grafanaServiceName DisplayName "Grafana"
& "C:\path\to\nssm.exe" set $grafanaServiceName Description "Grafana Monitoring Service"

# Start the services
& "C:\path\to\nssm.exe" start $prometheusServiceName
& "C:\path\to\nssm.exe" start $grafanaServiceName

Write-Host "Prometheus and Grafana services have been created and started using NSSM."
