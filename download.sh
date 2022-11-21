#!/usr/bin/env bash

export OTEL_VERSION=${OTEL_VERSION:-"0.64.1"}
export OS=${OS:-"linux_amd64"}

echo "   -> Cleaning directory"
rm otelcol-contrib;

mkdir -p .download

pushd .download
echo "   -> Downloading OpenTelemetry collector"
rm otelcol-contrib.tgz;
wget -O otelcol-contrib.tgz "https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v${OTEL_VERSION}/otelcol-contrib_${OTEL_VERSION}_${OS}.tar.gz"

echo "   -> Extracting OpenTelemetry collector"
tar xzf otelcol-contrib.tgz
rm LICENSE otelcol-contrib.tgz README.md
popd

echo "   -> Moving OpenTelemetry collector"
mv .download/otelcol-contrib .
chmod +x otelcol-contrib

echo "   Done."
