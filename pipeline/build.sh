# Prepares the contents and builds the lambda.zip file that contains the project
# source that needs to be uploaded to AWS Lambda during deployment

# Remove old artifacts
rm dist -rf
rm node_modules -rf
rm pipeline/lambda.zip
# Install all NPM packages
npm install
# Compile Typescript without source maps
npm run prod-build
# Remove NPM dev dependencies
npm prune --production
# Zip source files
node pipeline/zip-source.js
