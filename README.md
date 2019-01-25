# node-aws-lambda-typescript

## Prerequisites
* node ^8.10
* aws-cli (https://aws.amazon.com/cli/)
* 7-zip (for deployment to AWS Lambda)
* AWS Credentials with sufficient rights in the **.../aws/credentials** file


## Getting started and run server on dev machine
* `git clone https://github.com/bolddp/node-aws-lambda-typescript.git`
* `npm install`
* `npm run dev`
* `curl "http://localhost:3000/greeting?name=Doris Day"`

## Deploy to AWS
* `cd aws`
* `sh deploy-to-aws.sh`
* Fill out the data that is needed to deploy
  * AWS region, e.g. **eu-west-1**
  * AWS account ID (you can find it in the AWS Console -> Support -> Support center)
  * Name of existing S3 bucket where source code can be stored
  * Name of the CloudFormation stack (e.g. **greeting-api-dev**)
* Wait for the script to finish
* Go to AWS Console -> API Gateway -> APIs -> the name of your stack -> Stages -> prod -> Invoke URL, and copy the URL
* `curl <copied URL>/greeting`
