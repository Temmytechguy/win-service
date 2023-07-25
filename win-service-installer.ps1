param (
    [string]$RootDirectory
)

# Define the paths to Prometheus, Grafana, Windows Exporter, and NSSM executables
$prometheusPath = Join-Path $RootDirectory "prometheus.exe"
$grafanaPath = Join-Path $RootDirectory "grafana-server.exe"
$windowsExporterPath = Join-Path $RootDirectory "windows_exporter.exe"
$nssmPath = Join-Path $RootDirectory "nssm.exe"

# Define service names
$prometheusServiceName = "PrometheusService"
$grafanaServiceName = "GrafanaService"
$windowsExporterServiceName = "WindowsExporterService"

# Install Prometheus, Grafana, and Windows Exporter as services using NSSM
& $nssmPath install $prometheusServiceName $prometheusPath "--config.file=$RootDirectory\prometheus.yml"
& $nssmPath set $prometheusServiceName DisplayName "Prometheus"
& $nssmPath set $prometheusServiceName Description "Prometheus Monitoring Service"

& $nssmPath install $grafanaServiceName $grafanaPath "web"
& $nssmPath set $grafanaServiceName DisplayName "Grafana"
& $nssmPath set $grafanaServiceName Description "Grafana Monitoring Service"

& $nssmPath install $windowsExporterServiceName $windowsExporterPath
& $nssmPath set $windowsExporterServiceName DisplayName "Windows Exporter"
& $nssmPath set $windowsExporterServiceName Description "Windows Exporter Service"

# Start the services
& $nssmPath start $prometheusServiceName
& $nssmPath start $grafanaServiceName
& $nssmPath start $windowsExporterServiceName

Write-Host "Prometheus, Grafana, and Windows Exporter services have been created and started using NSSM."
