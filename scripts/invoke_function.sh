aws lambda invoke --function-name my-acm-check-function  out --log-type Tail --query 'LogResult' --output text |  base64 -d 
