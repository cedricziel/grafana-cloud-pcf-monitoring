#!/usr/bin/env bash

mkdir -p .download

pushd .download
echo "   -> Downloading OpenTelemetry collector"
rm otelcol-contrib.tgz;
wget -O otelcol-contrib.tgz https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.64.1/otelcol-contrib_0.64.1_linux_amd64.tar.gz

echo "   -> Extracting OpenTelemetry collector"
tar xzf otelcol-contrib.tgz
rm LICENSE otelcol-contrib.tgz README.md
popd

echo "   -> Moving OpenTelemetry collector"
mv .download/otelcol-contrib .
