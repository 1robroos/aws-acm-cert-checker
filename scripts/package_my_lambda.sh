#!/bin/sh
cp ../lambda/lambda.py .
zip -r deployment.zip lambda.py
aws s3 cp deployment.zip s3://companybucketrobroos/acmcheck/deployment.zip
rm lambda.py deployment.zip