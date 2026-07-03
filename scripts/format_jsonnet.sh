#!/bin/bash

while IFS= read -r -d '' file; do
	jsonnetfmt -i "$file"
done < <(find ./source \( -name '*.jsonnet' -o -name '*.libsonnet' \) -print0)
