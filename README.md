# node-aws-lambda-typescript

This is a demo / scaffolding project for developing an AWS Lambda / Node.js REST API using express.js in Typescript. During development it can be hosted on your local computer to test out.

You should be able to have a sample API up and running on AWS within 5 minutes, if you have all the prerequisites in place beforehand.

**NOTE!** This project was developed on Windows, so the scripts etc. haven't been tried out on OS X yet. You would definitely need to provide another path for the zip application in the **deploy-to-aws.sh** script. If you try it out on OS X and find any other problems, please create an issue.

## Prerequisites
* node ^8.10
* aws-cli - https://aws.amazon.com/cli/
* Windows: 7-zip (for deployment to AWS Lambda)
* Windows: sh (for instance by installing Git and make sure that you have **C:\Program Files\Git\cmd** in your path)
* AWS Credentials with sufficient rights in the AWS credentials file - https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html
* AWS S3 bucket to put the AWS Lambda zipped source code, where the AWS Credentials mentioned above have write access

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
  * Name of the CloudFormation stack that will be created (e.g. **greeting-api-dev**). This name will also be used for the API in API Gateway.
* Wait for the script to finish
* Go to AWS Console -> API Gateway -> APIs -> the name of your stack -> Stages -> prod -> Invoke URL, and copy the URL
* `curl <copied URL>/greeting`

## Todo / roadmap
* Create a custom domain that points at the API gateway.
* Put up samples of Cloudformation IAM policies that would give the Lambda access to other AWS resources.
* Add code to assign a role to be able to access these same AWS resources from dev computer.
* ...
