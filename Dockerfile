FROM ubuntu:24.04 AS build

ENV PATH="/root/.foundry/bin:${PATH}"

RUN apt-get update && apt-get install -y \
  bash \
  curl \
  g++ \
  jq \
  make \
  npm \
  python3

RUN npm install -g pnpm@latest-9

COPY . /app

WORKDIR /app/packages/contracts

RUN pnpm install

RUN printf "%s\n" \
  '#!/bin/bash' \
  'set -eu' \
  '' \
  'if [[ -f /secrets/keys ]]; then' \
  '  source /secrets/keys' \
  'fi' \
  '' \
  'sed -i '' -e "s/^PRIVATE_KEY=[^\$]*\$/PRIVATE_KEY=${PRIVATE_KEY}/" .env' \
  '' \
  'curl -s https://blockchain-gateway-stillness.live.tech.evefrontier.com/smartassemblies \' \
  '  | jq "{smartGateIds: [.[] | select(.assemblyType == \"SmartGate\" and .ownerId == \"${PUBLIC_KEY}\") | .id]}" \' \
  '  > smartGateIds.json' \
  '' \
  'pnpm configure-smart-gates' \
  > /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
