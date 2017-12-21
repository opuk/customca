#!/bin/bash 
#Generates a key and CSR

SERVER=$1

pushd ca/intermediate

openssl req -new -sha256 -nodes -out csr/$SERVER.csr -newkey rsa:4096 -keyout private/$SERVER.key -config <(
cat <<-EOF
[req]
default_bits = 4096
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
