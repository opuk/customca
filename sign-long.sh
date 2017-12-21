#!/bin/bash 
#Signing CSR with intermediate CA

export SUBJECTALTNAMERAW="DNS:$1, DNS:www.$1"

pushd ca/intermediate
openssl ca -config openssl.cnf \
      -extensions server_cert -days 365 -notext -md sha256 \
      -in csr/$1.csr \
      -out certs/$1.crt
chmod 444 certs/$1.crt
popd
