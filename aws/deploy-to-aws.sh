AWS_PROFILE="default"
AWS_REGION=""
AWS_ACCOUNT_ID=""
# The SAM (Serverless Application Model) uploads the zipped source code to
# an S3 bucket. This bucket needs to be available beforehand
AWS_S3_CODE_BUCKET_NAME=""
STACK_NAME=""

# This script needs 7-zip to be installed for automatic zipping of the source code
ZIP7_PATH="C:\Program Files\7-Zip\7z.exe"

##### Make sure it's freshly compiled
tsc

##### Zip source files

# Remove dev dependencies to make package smaller
rm lambda.zip
npm prune --production

"$ZIP7_PATH" a -r lambda.zip ./../node_modules
"$ZIP7_PATH" a -r lambda.zip ./../dist/* "-x!*.map"

# Restore all dependencies
npm install

# Query for empty input parameters
if [ -z "$AWS_PROFILE" ]
then
  echo "What AWS profile to use?"
  read AWS_PROFILE
fi

if [ -z "$AWS_REGION" ]
then
  echo "What region do you want to deploy to? (e.g. \"eu-west-1\")"
  read AWS_REGION
fi

if [ -z "$AWS_ACCOUNT_ID" ]
then
  echo Your AWS account id?
  read AWS_ACCOUNT_ID
fi

if [ -z "$AWS_S3_CODE_BUCKET_NAME" ]
then
  echo The name of an existing S3 bucket to put the code in?
  read AWS_S3_CODE_BUCKET_NAME
fi

if [ -z "$STACK_NAME" ]
then
  echo Name of the created Cloudformation stack?
  read STACK_NAME
fi

# Copy templates
cp cloudformation-template.yml cloudformation.yml
cp proxy-definition-template.yml proxy-definition.yml

# Search and replace of variables
sed "s#\${AWS_REGION}#$AWS_REGION#g" -i proxy-definition.yml
sed "s#\${AWS_ACCOUNT_ID}#$AWS_ACCOUNT_ID#g" -i proxy-definition.yml

sed "s#\${STACK_NAME}#$STACK_NAME#g" -i proxy-definition.yml

# Package and deploy to AWS
aws cloudformation package --profile "$AWS_PROFILE" --template-file cloudformation.yml --output-template-file serverless.yml --s3-bucket "${AWS_S3_CODE_BUCKET_NAME}"
aws cloudformation deploy --profile "$AWS_PROFILE" --template-file serverless.yml --stack-name ${STACK_NAME} --capabilities CAPABILITY_NAMED_IAM


