#! /bin/bash
# Deployment script to GreenQloud

jekyll build

echo "Switching to python2 so s3cmd doesn't break."
source activate website

echo "Deploying changes..."

s3cmd sync --exclude '.DS_Store' --exclude '.git/*' --exclude-from '.gitignore' --delete-removed --acl-public _site/ s3://www.tamasnagy.com

source deactivate