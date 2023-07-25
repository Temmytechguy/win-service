# Define the paths to Prometheus and Grafana executables
$prometheusPath = "C:\path\to\prometheus.exe"
$grafanaPath = "C:\path\to\grafana-server.exe"

# Define service names
$prometheusServiceName = "PrometheusService"
$grafanaServiceName = "GrafanaService"

# Create Prometheus service configuration
$prometheusServiceConfig = @"
<?xml version="1.0" encoding="utf-8"?>
<service>
  <displayname>Prometheus</displayname>
  <description>Prometheus Monitoring Service</description>
  <servicename>$prometheusServiceName</servicename>
  <executable>$prometheusPath</executable>
  <startarguments>prometheus --config.file=C:\path\to\prometheus.yml</startarguments>
  <logpath>C:\path\to\logs</logpath>
  <logmode>rotate</logmode>
</service>
"@

# Create Grafana service configuration
$grafanaServiceConfig = @"
<?xml version="1.0" encoding="utf-8"?>
<service>
  <displayname>Grafana</displayname>
  <description>Grafana Monitoring Service</description>
  <servicename>$grafanaServiceName</servicename>
  <executable>$grafanaPath</executable>
  <startarguments>web</startarguments>
  <logpath>C:\path\to\logs</logpath>
  <logmode>rotate</logmode>
</service>
"@

# Save the service configurations to XML files
$prometheusServiceConfigPath = "C:\path\to\prometheus-service.xml"
$grafanaServiceConfigPath = "C:\path\to\grafana-service.xml"

$prometheusServiceConfig | Out-File -Encoding utf8 $prometheusServiceConfigPath
$grafanaServiceConfig | Out-File -Encoding utf8 $grafanaServiceConfigPath

# Create and install the services
New-Service -Name $prometheusServiceName -BinaryPathName "C:\Windows\System32\cmd.exe /c $prometheusPath --config.file=$prometheusServiceConfigPath"
New-Service -Name $grafanaServiceName -BinaryPathName "C:\Windows\System32\cmd.exe /c $grafanaPath -homepath $grafanaPath --config=C:\path\to\grafana.ini"

# Start the services
Start-Service -Name $prometheusServiceName
Start-Service -Name $grafanaServiceName

Write-Host "Prometheus and Grafana services have been created and started."
