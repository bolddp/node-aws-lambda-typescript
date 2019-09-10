# NOTE! This script should be executed from the project root

ENV_TYPE="dev"
AWS_PROFILE="default"
STACK_NAME="my-stack" # should not include the environment type, it will be appended to the stack name
AWS_S3_CODE_BUCKET_NAME="my-code-bucket"
BUILD_NUMBER="0"

sh pipeline/build.sh
read -p "Lambda.zip generated. Press ENTER to deploy..."
# Copy the zip file to make it available for the template CodeUri reference
cp pipeline/lambda.zip aws/lambda.zip
aws cloudformation package --profile "$AWS_PROFILE" --template-file aws/template.yml --output-template-file aws/template.sam.yml --s3-bucket "${AWS_S3_CODE_BUCKET_NAME}"
aws cloudformation deploy --profile "$AWS_PROFILE" --template-file aws/template.sam.yml --stack-name ${STACK_NAME}-${ENV_TYPE} --capabilities CAPABILITY_NAMED_IAM --parameter-overrides EnvironmentType=${ENV_TYPE} BuildNumber=${BUILD_NUMBER}
# Clean up
rm pipeline/lambda.zip
rm aws/lambda.zip
rm aws/template.sam.yml
# Install all NPM packages again
npm install
