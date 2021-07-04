#REG     := 387603950885.dkr.ecr.eu-central-1.amazonaws.com/nginx-fargate
#HASH    := $(shell git rev-parse --short HEAD)
#BRANCH  := $(shell echo $(shell git symbolic-ref --short -q HEAD) | sed 's|/|\-|g' )
#TAG     := ${BRANCH}-${HASH}
#IMG     := ${REG}:${TAG}
#LATEST  := ${REG}:latest

default: lambda_upload_to_s3 deployCFN

#build:
#        docker build -t ${IMG} .
#
#        #push:
#        #/home/rob/Downloads/DAIMLER/CLI/Bash/IdpCli configure-credentials -a 387603950885 -r DhcFullAdmin
        #export AWS_PROFILE=Idp387603950885DhcFullAdmin
	#        aws ecr get-login-password --region eu-central-1 |docker login -u AWS --password-stdin  https://387603950885.dkr.ecr.eu-central-1.amazonaws.com
	#                #aws ecr get-login-password --region eu-central-1 |docker login -u AWS --password-stdin  https://969526043371.dkr.ecr.eu-central-1.amazonaws.com
	#        docker push ${IMG}
	#        #        docker tag ${IMG} ${LATEST}
	#        docker push ${LATEST}
	#        # if develop also tag/push as latest
	#ifeq ($(BRANCH),develop)
	#        echo "Tag as ${LATEST}"
	#        #        docker tag ${IMG} ${LATEST}
	#        docker push ${LATEST}
	#        #else
	#        echo 'No develop or release, no additional docker tagging and pushing'
	#        #endif
	#
	#deployCFNinPRD:
lambda_upload_to_s3:
		cp ../lambda/lambda.py .
		zip -r deployment.zip lambda.py
		aws s3 cp deployment.zip s3://kfsolutions-code-eu-central-1/acmcheck/deployment.zip
		rm lambda.py deployment.zip
deployCFN:	
		aws cloudformation deploy --template-file /home/ec2-user/environment/pythonacmcheck/aws-acm-cert-checker/cloudformation/Cloudformation-acm-check.json  --stack-name acm-check --capabilities CAPABILITY_NAMED_IAM  --region eu-central-1 --s3-bucket cf-templates-3mz2622gpxvp-eu-central-1

updatelambda:
		aws lambda update-function-code --function-name acm-check --s3-bucket kfsolutions-code-eu-central-1 --s3-key acmcheck/deployment.zip --region eu-central-1
		#updateservice:
		#        #aws ecs update-service --force-new-deployment --cluster AthlonVPC1-nginx-fargate-cluster --service AthlonVPC1-nginx-fargate-service --region eu-central-1
		#        aws ecs update-service --force-new-deployment --cluster AthlonVPC1-keycloak-fargate-cluster --service AthlonVPC1-Nginx-Fargate-NginxFargateService-tBBMbUO4bt5O --region eu-central-1
		#
		#        #updatenginxconf:
		#        athint
		#        #        aws s3 cp app.conf s3://rr-compliance-testbucket/app.conf


