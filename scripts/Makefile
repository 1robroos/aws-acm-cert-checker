#REG     := 387603950885.dkr.ecr.eu-central-1.amazonaws.com/nginx-fargate
#HASH    := $(shell git rev-parse --short HEAD)
#BRANCH  := $(shell echo $(shell git symbolic-ref --short -q HEAD) | sed 's|/|\-|g' )
#TAG     := ${BRANCH}-${HASH}
#IMG     := ${REG}:${TAG}
#LATEST  := ${REG}:latest

default: lambda_upload_to_s3 deployCFN

lambda_upload_to_s3:
		cp ../lambda/lambda.py .
		zip -r deployment.zip lambda.py
		aws s3 cp deployment.zip s3://kfsolutions-code-eu-central-1/acmcheck/deployment.zip
		rm lambda.py deployment.zip
deployCFN:	
		aws cloudformation deploy --template-file /home/ec2-user/environment/pythonacmcheck/aws-acm-cert-checker/cloudformation/Cloudformation-acm-check.json  \
		--stack-name acm-check --capabilities CAPABILITY_NAMED_IAM  --region eu-central-1 --s3-bucket cf-templates-3mz2622gpxvp-eu-central-1 \
		--parameter-overrides Bucket=kfsolutions-code-eu-central-1 BucketKeyLambda=acmcheck \
		SNSTopic=arn:aws:sns:eu-central-1:969526043371:kfsolutions-email Schedule="cron(0 12 * * ? *)" LambdaZipFile=deployment.zip

updatelambda:
		aws lambda update-function-code --function-name acm-check --s3-bucket kfsolutions-code-eu-central-1 --s3-key acmcheck/deployment.zip --region eu-central-1
