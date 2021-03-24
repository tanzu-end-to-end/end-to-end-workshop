#!/bin/bash
set -x


if [ $WORKSHOP_FILE == "workshop-tbs-gitops.yaml" ]
then
  START_TIME=$(date +%s000)
  END_TIME=$(date +%s000)

  curl \
    -X POST \
    --header "Content-Type: application/json" \
    --header "Accept: application/json" \
    --header "Authorization: Bearer ${OBSERVABILITY_API_TOKEN}" \
    -d "{
      \"name\": \"\Build Spring WebDB\",
      \"annotations\": {
        \"severity\": \"info\",
        \"type\": \"image build\",
        \"details\": \"new build of Spring WebDB\"
      },
      \"startTime\": "${START_TIME}",
      \"endTime\": "${END_TIME}"
    }" "${OBSERVABILITY_URL}/api/v2/event"
fi