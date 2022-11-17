# OpenTelemetry collector deployment for PCF

## Prepare

### Download the dependency

This app depends on the OpenTelemetry collector.

```bash
./download.sh
```

### Prepare credentials for Grafana Cloud

1. go to Grafana.com to manage your account
2. select your stack
3. click "Send metrics" on the Prometheus instance
![./resources/stack.png](./resources/stack.png)

4. note down the URL for "Remote Write Endpoint" & "Username / Instance ID"
![./resources/prom.png](./resources/prom.png)

5. create a new API key with "MetricsPublisher" role in "Password / API Key" and note the API key
![./resources/stack.png](./resources/apikey.png)

### Prepare credentials for CloudFoundry

For the CloudFoundry receiver, you need to provide the following environment variables. You probably
need to check with your foundation administrator.

[This page](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/cloudfoundryreceiver#authentication) contains instructions on how to retrieve the credentials needed from UAA.

* `RLP_GATEWAY_ENDPOINT` - URL of the RLP gateway, typically `https://log-stream.<cf-system-domain>`
* `RLP_GATEWAY_TLS_INSECURE` - `true/false` whether to skip TLS verify for the RLP gateway endpoint
* `UAA_ENDPOINT` - URL of the UAA provider, typically `https://uaa.<cf-system-domain>`
* `UAA_USERNAME` - name of the UAA user (required grant types/authorities described above)
* `UAA_PASSWORD` - password of the UAA user
* `UAA_TLS_INSECURE` - `true/false` whether to skip TLS verify for the UAA endpoint. Default: `false`

## Deployment

This app is supposed to use the binary buildpack.

```bash
cf push grafana-pcf-monitoring
```

### Prepare your environment variables

We need to supply the application with some environment variables for configuration

* `GRAFANA_REMOTE_WRITE_URL` - The "Remote Write Endpoint" you noted down earlier
* `GRAFANA_USER_ID` - The "Username / Instance ID" you noted down earlier
* `GRAFANA_TOKEN` - The "Password / API Key" you noted down earlier

* `RLP_GATEWAY_ENDPOINT` - URL of the RLP gateway, typically `https://log-stream.<cf-system-domain>`
* `RLP_GATEWAY_TLS_INSECURE` - `true/false` whether to skip TLS verify for the RLP gateway endpoint
* `UAA_ENDPOINT` - URL of the UAA provider, typically `https://uaa.<cf-system-domain>`
* `UAA_USERNAME` - name of the UAA user (required grant types/authorities described above)
* `UAA_PASSWORD` - password of the UAA user
* `UAA_TLS_INSECURE` - `true/false` whether to skip TLS verify for the UAA endpoint. Default: `false`

### Apply environment variables

For every environment variable above, set it through the CLI.

For example:

```bash
cf set-env grafana-pcf-monitoring GRAFANA_REMOTE_WRITE_URL https://...../api/prom/push
```
