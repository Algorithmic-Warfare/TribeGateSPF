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
4. Run the following script

```sh
pnpm configure-smart-gates
```

## Notes

- You do not need to deploy the following codebase. It is already deployed.
- Do not change anything about the code. Just follow the above steps.