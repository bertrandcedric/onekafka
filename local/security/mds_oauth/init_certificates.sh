#!/bin/bash
# Generate keys and certificates used by MDS
if [ \! -e ./keypair/private.pem ]; then
    echo -e "Generate keys and certificates used for MDS"

    openssl genrsa -out ./keypair/private.pem 2048; openssl rsa -in ./keypair/private.pem -outform PEM -pubout -out ./keypair/public.pem
    chmod 644 ./keypair/private.pem ./keypair/public.pem
fi
