# PoC Guide - ERN Protocol

## Test Template
Use `test/PoC.t.sol` as the base for all PoC tests. It forks Ethereum mainnet using `MAINNET_RPC_URL`.

## Running Tests
```bash
MAINNET_RPC_URL="<your_rpc>" forge test --fork-url $MAINNET_RPC_URL --match-contract PoC -vvv
```

## Deployed Contracts (Ethereum Mainnet — Direct, No Proxies)
| Contract | Address |
|----------|---------|
| ernUSDT | `0x87f0E6f65CCf64d6D504C9DB95F390d2aCb033B5` |
| ernUSDC | `0x226455A82E30Ff05E68B37b99C59e503104bA84B` |
| RewardsDistributor | `0x9F76037494092aCeAc5B23E21C20B1970a866eF5` |

**None of these contracts use proxies** — interact with the addresses above directly.

## Protocol Overview
- **Ern.sol**: Vault that accepts USDT/USDC deposits, supplies to Aave V3, and periodically harvests yield → swaps to WBTC reward token via Uniswap V3. Users get 1:1 shares. Lock period on deposits (48h soft lock, 20s hard lock). Withdrawal fee during lock period.
- **RewardsDistributor.sol**: Separate allocation-based rewards. Allocators assign token amounts to users. Users (or distributors) can claim. Pausable with emergency withdraw.

## Key External Dependencies
- Aave V3 Pool (via AddressesProvider `0x2f39d218133AFaB8F2B819B1066c7E434Ad94E9e`)
- Uniswap V3 Router (`0xE592427A0AEce92De3Edee1F18E0157C05861564`)

## Gotchas
- The Ern vault **owner** (`0xeA361071D4E88665E79ce3bd1d8DaDb5755C3bed`) is NOT necessarily a harvester on the live contracts. The constructor sets `msg.sender` (deployer) as the initial harvester.
- The RewardsDistributor admin is NOT the same as the Ern vault owner.
- Transfers of Ern shares are **blocked** (non-transferable ERC20). Only mint/burn via deposit/withdraw.
- Use `deal()` to set up token balances for test actors.

## Key Areas for Security Review
- Yield accounting (cumulativeRewardPerShare math)
- Deposit/withdraw lock period logic
- Harvest conditions and fee calculations
- RewardsDistributor allocation/claim accounting
- Integration with Aave V3 and DEX

## Bug Bounty Rules
- Reference: https://immunefi.com/bug-bounty/ern/scope/#top
- PoCs must demonstrate real impact on mainnet fork
- Testing on local forks only (no mainnet/testnet interaction)
