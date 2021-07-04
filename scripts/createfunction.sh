#!/bin/bash
# aws lambda create-function --function-name my-acm-check-function \
#--zip-file fileb:///home/ec2-user/environment/pythonacmcheck/aws-acm-cert-checker/deployment.zip --handler lambda.lambda_handler --runtime python3.7 \
#--role arn:aws:iam::969526043371:role/ExecutelambdaRole
aws lambda create-function --function-name my-acm-check-function \
--zip-file fileb://deployment.zip --handler lambda.lambda_handler --runtime python3.8 \
--role arn:aws:iam::969526043371:role/LambdaAdminRole --timeout 60
RC=$?
if [ $RC == 0 ]
then
    aws lambda update-function-configuration --function-name my-acm-check-function \
    --environment "Variables={ALERT_METHOD=SNS,SNS_ARN=arn:aws:sns:eu-central-1:969526043371:kfsolutions-email}"
fi 
    