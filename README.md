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
```

1. Build the docker image

### Using environemntal variables

```
docker run --rm --env PUBLIC_KEY=_YOUR_PUBLIC_KEY_ --env PRIVATE_KEY=_YOUR_PRIVATE_KEY_ configure-smart-gates
```

2. Run the configure-smart-gates script with public and private keys passed with environmental
   variables.

### Using docker volume

```
docker volume create eve-keys

docker run -i --rm --mount type=volume,src=eve-keys,dst=/secrets --entrypoint bash configure-smart-gates -c "cat - > /secrets/keys" <<EOF
PUBLIC_KEY=YOUR_PUBLIC_KEY
PRIVATE_KEY=YOUR_PRIVATE_KEY
EOF
```

2. Create a volume called `eve-keys` that is mounted on `/secrets` and add your keys to the file
   `/secrets/keys`.

```
docker run -t --rm --mount type=volume,src=eve-keys,dst=/secrets configure-smart-gates
```

3. Run the configure-smart-gates image, which will read the keys from `/secrets/keys` before calling
   `pnpm configure-smart-gates`.


## Notes

- You do not need to deploy the following codebase. It is already deployed.
- Do not change anything about the code. Just follow the above steps.
