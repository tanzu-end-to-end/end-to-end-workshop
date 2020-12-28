# Configuring TLS Certificate Delegation

Ensure that you have prepared a values.yaml file, by customizing the values-example.yaml file in the root of this repo.

From this directory in the repo, execute:

```
./install-tls-cert.sh /path/to/my/values.yaml
```

This will ensure that all applications in other namespaces will be able to terminate TLS using your configured wildcard certificate.