#! /bin/bash
# Deployment script to GreenQloud

jekyll build

echo "Deploying changes..."

s3cmd sync --exclude '.DS_Store' --exclude '.git/*' --exclude-from '.gitignore' --delete-removed --acl-public _site/ s3://www.tamasnagy.com
