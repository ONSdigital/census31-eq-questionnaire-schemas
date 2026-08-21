#!/bin/bash

# NOTE: This script expects to be run from the project root with
# ./scripts/lint_jsonnet.sh

failures=0
while IFS= read -r -d '' file; do
    if ! jsonnetfmt --test -i "$file"; then
        echo "'$file' failed Jsonnet format check. Run 'jsonnetfmt -i $file' to fix."
        ((failures += 1))
    fi
done < <(find ./source \( -name '*.jsonnet' -o -name '*.libsonnet' \) -print0)

if [ "$failures" -gt 0 ]; then
    exit 1
fi
