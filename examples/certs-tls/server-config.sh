{

cat > server-csr.json <<EOF
{
  "CN": "server",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "L": "Salt Lake City",
      "O": "cassandra:servers",
      "OU": "Cassandra Bare Cert Support",
      "ST": "Utah"
    }
  ]
}
EOF

cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=cassandra \
  server-csr.json | cfssljson -bare server

openssl pkcs8 -topk8 -nocrypt -in server-key.pem -out server-pkcs8-key.pem
}
