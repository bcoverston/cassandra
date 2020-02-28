cat > client-csr.json <<EOF
{
  "CN": "cassandra:client",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Salt Lake City",
      "O": "cassandra:client",
      "OU": "Cassandra",
      "ST": "Utah"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=127.0.0.1 \
  -profile=cassandra \
  client-csr.json | cfssljson -bare client

openssl pkcs8 -topk8 -nocrypt -in client-key.pem -out client-pkcs8-key.pem
