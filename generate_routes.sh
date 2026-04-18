#!/bin/bash

[ "${1:-x}" = 'x' ] && exit 1

env="$1"
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
routes=$script_dir/$1/routes
values=$routes/values.yaml
cat > $values << 'EOF'
# this file is auto-generated from routes/ directory
# do not edit manually - changes will be overwritten
routes:
EOF

echo 'processing route files...'
for file in $routes/*.json; do
  if [ -f "$file" ]; then
    filename=$(basename "$file" .json)
    echo " processing: $filename"

    echo "  $filename: |" >> $values
    jq -r . "$file" | sed 's/^/    /' >> $values
    echo '' >> $values
  fi
done

echo "generated $values with $(ls $routes/*.json | wc -l) routes"
