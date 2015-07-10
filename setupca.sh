#!/bin/bash

openssl genrsa -out rootCA.key 4096 -des3
openssl req -x509 -new -nodes -key rootCA.key -days 1024 -out rootCA.pem
