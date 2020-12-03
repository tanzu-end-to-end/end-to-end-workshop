#!/bin/bash
REGISTRY_PASSWORD=Harbor12345 kp secret create harbor-creds --registry harbor.$INGRESS_DOMAIN --registry-user admin