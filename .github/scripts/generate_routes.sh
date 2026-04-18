#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

cat > routes/values.yaml << 'EOF'
# this file is auto-generated from routes/ directory
# do not edit manually - changes will be overwritten
routes:
EOF

echo 'processing route files...'
for file in routes/*.json; do
  if [ -f "$file" ]; then
    filename=$(basename "$file" .json)
    echo " processing: $filename"

    echo "  $filename: |" >> routes/values.yaml
    jq -r . "$file" | sed 's/^/    /' >> routes/values.yaml
    echo '' >> routes/values.yaml
  fi
done

echo "generated routes/values.yaml with $(ls routes/*.json | wc -l) routes"
