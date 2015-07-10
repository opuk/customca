#!/bin/bash

openssl x509 -req -in devices/$1.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out devices/$1.crt -days 365
