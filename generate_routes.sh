#!/bin/bash

set -euo pipefail

[ "${1:-x}" = 'x' ] && exit 1

routes="$1/routes"
values="$routes/values.yaml"
values_tmp="$(mktemp -p /tmp values.yaml.XXXXXX)"
trap 'rm -f "$values_tmp"' EXIT
cat > "$values_tmp" << 'EOF'
# this file is auto-generated from routes/ directory
# do not edit manually - changes will be overwritten
routes:
EOF

echo 'processing route files...'
for file in $routes/*.json; do
  if [ -f "$file" ]; then
    filename=$(basename "$file" .json)
    echo " processing: $filename"

    echo "  $filename: |" >> "$values_tmp"
    jq -r . "$file" | sed 's/^/    /' >> "$values_tmp"
    echo '' >> "$values_tmp"
  fi
done

mv "$values_tmp" "$values"
echo "generated $values with $(ls $routes/*.json | wc -l) routes"
