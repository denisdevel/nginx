#!/bin/bash
SERVICE_NAME="nginx-service"
IMAGE_VERSION="v_"${BUILD_NUMBER}
TASK_FAMILY="nginx"

## Create a new task definition for this build
sed -e "s;%BUILD_NUMBER%;${BUILD_NUMBER};g" nginx.json > nginx-v_${BUILD_NUMBER}.json
aws ecs register-task-definition --family nginx --cli-input-json file://nginx-v_${BUILD_NUMBER}.json

# Update the service with the new task definition and desired count
TASK_REVISION=`aws ecs describe-task-definition --task-definition nginx | egrep "revision" | tr "/" " " | awk '{print $2}' | sed 's/"$//'`
DESIRED_COUNT=`aws ecs describe-services --cluster nginx --services ${SERVICE_NAME} | egrep "desiredCount" | tr "/" " " | awk '{print $2}' | sed 's/,$//' | head -1`
if [ ${DESIRED_COUNT} = "0" ]; then
    DESIRED_COUNT="1"
fi

LOG1="aws ecs update-service --cluster nginx --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count ${DESIRED_COUNT}"
echo ${LOG1}
aws ecs update-service --cluster nginx --service ${SERVICE_NAME} --task-definition ${TASK_FAMILY}:${TASK_REVISION} --desired-count ${DESIRED_COUNT}
