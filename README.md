# TribeGateSPF

An SPF "Precursor" (Smart Program Frame) for the AWAR gate system.

## Usage

1. Move to contract folder

```sh
cd ./packages/contracts
```

2. Install dependencies

```sh
pnpm install
```

2. Place your private key in the `./packages/contracts/.env`
3. Fill in your list of smartGateIds in `./packages/contracts/smartGateIds.json`

```sh
curl -s https://blockchain-gateway-stillness.live.tech.evefrontier.com/smartassemblies | jq '{smartGateIds: [.[] | select(.assemblyType == "SmartGate" and .ownerId == "YOUR CHARACTER ADDRESS") | .id]}' > smartGateIds.json
```
4. Run the following script

```sh
pnpm configure-smart-gates
```

## Docker

```
docker build --tag configure-smart-gates .

docker run --rm --env PUBLIC_KEY=_YOUR_PUBLIC_KEY_ --env PRIVATE_KEY=_YOUR_PRIVATE_KEY_ configure-smart-gates
```


## Notes

- You do not need to deploy the following codebase. It is already deployed.
- Do not change anything about the code. Just follow the above steps.
