#!/bin/sh
# Create the compact identity reference accepted by fal's inline upload route.
set -eu
source_image=${1:-assets/01-riley/images/riley-01-v01.png}
output_image=${2:-assets/references/prepared-identity/riley-reference-512.jpg}
if [ -e "$output_image" ]; then
  echo "Output already exists: $output_image" >&2
  exit 1
fi
mkdir -p "$(dirname "$output_image")"
sips -Z 512 -s format jpeg -s formatOptions 65 "$source_image" --out "$output_image"
python3 - "$output_image" <<'PY'
import sys
from pathlib import Path
p = Path(sys.argv[1])
assert p.stat().st_size <= 65536, 'Reference exceeds the 64 KiB inline upload limit'
print(f'{p}: {p.stat().st_size} bytes')
PY
