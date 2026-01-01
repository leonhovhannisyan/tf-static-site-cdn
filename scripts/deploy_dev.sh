#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_DIR="${ROOT_DIR}/envs/dev"

#user terraform output to get bucket name and cloudfront distribution id
BUCKET="$(
  cd "${ENV_DIR}" && terraform output -raw bucket_name
)"
CF_ID="$(
  cd "${ENV_DIR}" && terraform output -raw cloudfront_distribution_id 2>/dev/null || true
)"

echo "Deploying site/ -> s3://${BUCKET}/"

#Upload site to S3
aws s3 sync "${ROOT_DIR}/site" "s3://${BUCKET}/" --delete --exact-timestamps

#Make sure index.html isn't cached forever
aws s3 cp "${ROOT_DIR}/site/index.html" "s3://${BUCKET}/index.html" \
  --content-type "text/html" \
  --cache-control "no-cache, no-store, must-revalidate"

CF_ID="$(cd "${ENV_DIR}" && terraform output -raw cloudfront_distribution_id)"

echo "Creating CloudFront invalidation..."
aws cloudfront create-invalidation --distribution-id "${CF_ID}" --paths "/*" >/dev/null
echo "Invalidation requested."

echo "Done."
