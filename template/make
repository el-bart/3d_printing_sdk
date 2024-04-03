#!/bin/bash
set -eu -o pipefail
app_dir=$(dirname "$(readlink -e "$0")")
exec "$app_dir/sdk" make "$@"
