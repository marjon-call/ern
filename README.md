# Ern - Security Review

## In-Scope Contracts (Ethereum Mainnet)
- **Ern** (ernUSDT) — `0x87f0E6f65CCf64d6D504C9DB95F390d2aCb033B5`
- **Ern** (ernUSDC) — `0x226455A82E30Ff05E68B37b99C59e503104bA84B`
- **RewardsDistributor** — `0x9F76037494092aCeAc5B23E21C20B1970a866eF5`

Both Ern deployments use identical contract code (one for USDT, one for USDC).

## Protocol Overview
Ern is a yield vault that accepts stablecoin deposits (USDT/USDC), supplies them to Aave V3, and periodically harvests the accrued yield — swapping it to WBTC via a DEX (Uniswap V3 pattern). Users receive 1:1 shares on deposit. A RewardsDistributor contract handles separate allocation-based reward distribution.

## Project Structure
```
src/
  Ern.sol                  # Main vault contract (ERC20, Ownable)
  RewardsDistributor.sol   # Rewards allocation & claiming (AccessControl, Pausable)
  interfaces/              # Protocol interfaces
  dependencies/            # OpenZeppelin v5.3.0
```

## Bug Bounty
https://immunefi.com/bug-bounty/ern/scope/#top
