#!/bin/bash -x
#Generates a key and CSR

pushd ca/intermediate

openssl genrsa \
      -out private/$1.key 2048

chmod 400 private/$1.key

openssl req -config openssl.cnf \
      -key private/$1.key \
      -new -sha256 -out csr/$1.csr


