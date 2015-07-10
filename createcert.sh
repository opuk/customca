#!/bin/bash

mkdir -p devices

openssl genrsa -out devices/$1.key 2048
openssl req -new -key devices/$1.key -out devices/$1.csr

