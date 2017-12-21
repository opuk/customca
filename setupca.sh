#!/bin/bash
#Sets up a root CA and a intermediate CA

mkdir -p ca
pushd ca
export SUBJECTALTNAMERAW=''

#init root ca
ln -s ../root.cnf openssl.cnf
mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

openssl genrsa -aes256 -out private/ca.key 4096

chmod 400 private/ca.key

openssl req -config openssl.cnf \
        -key private/ca.key \
        -new -x509 -days 365 -sha256 -extensions v3_ca \
        -out certs/ca.crt

openssl x509 -noout -text -in certs/ca.crt

#intermediate
mkdir -p intermediate
pushd intermediate
ln -s ../../intermediate.cnf openssl.cnf

mkdir certs crl csr newcerts private
echo 1000 > crlnumber
chmod 700 private
touch index.txt
echo 1000 > serial

openssl genrsa -aes256 \
        -out private/intermediate.key 4096

chmod 400 private/intermediate.key

openssl req -config openssl.cnf -new -sha256 \
      -key private/intermediate.key \
      -out csr/intermediate.csr

popd

openssl ca -config openssl.cnf -extensions v3_intermediate_ca \
      -days 180 -notext -md sha256 \
      -in intermediate/csr/intermediate.csr \
      -out intermediate/certs/intermediate.crt

chmod 444 intermediate/certs/intermediate.crt

#create ca-chain file to distribute

cat intermediate/certs/intermediate.crt certs/ca.crt > intermediate/certs/ca-chain.pem

popd
