#!/bin/bash
# Generate keys and certificates used by MDS
if [ \! -e ./keypair/keypair.pem ]; then
    echo -e "Generate keys and certificates used for MDS"

    openssl genrsa -out ./keypair/keypair.pem 2048; openssl rsa -in ./keypair/keypair.pem -outform PEM -pubout -out ./keypair/public.pem
    chmod 644 ./keypair/keypair.pem ./keypair/public.pem
fi
