#!/usr/bin/env bash
mkcert -install
mkdir certs
mkcert -cert-file certs/local-cert.pem -key-file certs/local-key.pem "docker.localhost" "*.docker.localhost"
