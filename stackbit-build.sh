#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://artem-stackbit.ngrok.io/project/5f5b5f3d13c86918504e3d79/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://artem-stackbit.ngrok.io/pull/5f5b5f3d13c86918504e3d79
fi
curl -s -X POST https://artem-stackbit.ngrok.io/project/5f5b5f3d13c86918504e3d79/webhook/build/ssgbuild > /dev/null
jekyll build
curl -s -X POST https://artem-stackbit.ngrok.io/project/5f5b5f3d13c86918504e3d79/webhook/build/publish > /dev/null
