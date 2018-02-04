#!/bin/bash
#Generates a key and CSR
 
SERVER=$1
 
pushd ca/intermediate
 
openssl ecparam -genkey -name prime256v1 -out private/$SERVER.key
 
openssl req -new -key private/$SERVER.key -out csr/$SERVER.csr -config <(
cat <<-EOF
[req]
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn
 
[ dn ]
C=SE
ST=Stockholm
O=opuk lab
OU=lab unit
emailAddress=root@example.com
CN = $SERVER
 
[ req_ext ]
subjectAltName = @alt_names
 
[ alt_names ]
DNS.1 = $SERVER
DNS.2 = www.$SERVER
EOF
)
 
chmod 400 private/$1.key
