#!/bin/bash
set -e
cd $(dirname $0)
gcloud workflows deploy morning-ai-bot --source=workflow.yaml --service-account=daily-batch@${project}.iam.gserviceaccount.com --location=${REGION}

cd ./cloud-functions
gcloud beta functions deploy morning-ai-bot \
  --entry-point morning_ai_bot --runtime python37 --trigger-http --memory 2048MB --timeout 500s --region ${REGION} \
  --set-secrets MORNING_AI_BOT_TOKEN=MORNING_AI_BOT_TOKEN:latest,TWITTER_TOKEN=TWITTER_TOKEN:latest
