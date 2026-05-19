# ChestNutCoin (CNUT)

A simple ERC-20 meme coin built with [Foundry](https://getfoundry.sh/) and [OpenZeppelin](https://www.openzeppelin.com/contracts), deployed on [Base](https://base.org).

This is a hobby / teaching project. The contract is intentionally minimal: a fixed supply of **1,000,000 CNUT** is minted to the deployer at creation, and there are **no** mint, burn, pause, or owner powers afterward.

## Deployed addresses

| Network        | Chain ID | Contract address              | Explorer |
| -------------- | -------- | ----------------------------- | -------- |
| Base Sepolia   | 84532    | `0x5b02DE1D7D3E18b9892EeB3BDf7A6DD0D15549C5` | [view](https://sepolia.basescan.org/address/0x5b02DE1D7D3E18b9892EeB3BDf7A6DD0D15549C5) |
| Base mainnet   | 8453     | _TBD — fill in after deploy_  | https://basescan.org/address/TBD |

## Project layout

```
src/MemeCoin.sol       — the ERC-20 contract
test/MemeCoin.t.sol    — forge-std tests
script/Deploy.s.sol    — deploy script (reads TOKEN_NAME / TOKEN_SYMBOL / PRIVATE_KEY from env)
foundry.toml           — Foundry config, including base_sepolia + base_mainnet RPC endpoints
.env.example           — template for required env vars
```

## Prerequisites

1. **Foundry** — install with:
   ```sh
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```
2. **A deploy wallet** with some testnet ETH on Base Sepolia. Get free Base Sepolia ETH from a faucet such as the [Coinbase Wallet Faucet](https://www.coinbase.com/faucets/base-ethereum-sepolia-faucet) or [Alchemy Sepolia Faucet](https://www.alchemy.com/faucets/base-sepolia) (some faucets give you ETH Sepolia which you then bridge to Base Sepolia).
3. **An Etherscan API key** (free) for contract verification. Sign up at https://etherscan.io and create a key in your API dashboard — Etherscan unified verification for Base, Polygon, Arbitrum, etc. under a single key (Etherscan API V2).

## Setup

```sh
git clone <this repo>
cd chestnutcoin
forge install                       # pulls submodules (forge-std, openzeppelin-contracts)
cp .env.example .env                # then fill in real values
forge build
forge test -vv
```

## Deploy

### Base Sepolia (testnet)

```sh
source .env
forge script script/Deploy.s.sol:Deploy \
  --rpc-url base_sepolia \
  --broadcast \
  --verify
```

Copy the printed contract address into the table above under **Base Sepolia**, then commit.

### Base mainnet

Only do this once you've successfully deployed to Sepolia and confirmed everything works.

```sh
source .env
forge script script/Deploy.s.sol:Deploy \
  --rpc-url base_mainnet \
  --broadcast \
  --verify
```

Copy the printed address into the table above under **Base mainnet**.

## Safety notes

- **Never commit `.env`.** It contains your private key. The `.gitignore` excludes it by default — keep it that way.
- For mainnet, **never reuse a throwaway testnet key.** Generate a fresh one (e.g. with `cast wallet new`) and fund it only with what you need.
- The contract has no admin functions. Once deployed, the supply is permanently fixed and you cannot upgrade or pause it. This is by design.

## What the contract does

`MemeCoin` extends OpenZeppelin's audited `ERC20`. The constructor takes a `name` and `symbol`, then mints `INITIAL_SUPPLY` (1,000,000 × 10¹⁸) tokens to the deployer's address. That's it.

If you want to understand the moving parts, the interesting reads are:
- `lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol` — the base implementation
- `src/MemeCoin.sol` — our 20-line wrapper
- `test/MemeCoin.t.sol` — tests that exercise total supply, balances, and transfers
