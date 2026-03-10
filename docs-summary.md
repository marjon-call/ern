# ERN Protocol Documentation Summary

## What is ERN?

ERN is a decentralized finance (DeFi) platform designed to maximize the utility of stablecoins. It operates on the Ethereum mainnet and leverages established lending markets to generate returns while keeping assets accessible and transparent.

Unlike traditional savings accounts or protocols where you earn interest in the same currency you deposit, **ERN allows you to deposit stablecoins and earn your yield entirely in Bitcoin**. This lets you maintain a stable, less volatile principal (USDC/USDT) while accumulating a high-growth asset (Bitcoin) as interest.

## How ERN Works

1. **Deposit Stablecoins:** You deposit USDC or USDT into the ERN protocol.
2. **Earn Bitcoin Daily:** The platform puts your stablecoins to work in secure lending protocols. The yield generated is automatically converted and paid out to you daily in Bitcoin (wBTC).
3. **Withdraw Anytime:** There are no lock-up periods. You can withdraw your initial stablecoin deposit and your earned Bitcoin whenever you choose.

### Key Features

- **Stablecoins in, Bitcoin out:** Maintain stable principal while accumulating Bitcoin as interest.
- **Daily Payouts:** Yield is calculated and paid out every day.
- **No Lock-Up Periods:** Withdrawals are processed immediately.
- **Self-Custody:** Non-custodial. The platform does not hold or control your funds.
- **Transparent & Audited:** Externally audited and runs entirely on-chain.

## Decentralized Money Markets (DMMs)

DMMs are on-chain financial protocols that allow users to lend, borrow, and earn yield on digital assets without intermediaries. ERN integrates with established DMMs such as Aave V3, which have undergone extensive auditing and stress testing.

### How ERN Uses DMMs

1. Funds are supplied to DMMs on Ethereum
2. Deposited capital earns interest from borrowers within the DMM
3. Earned yield is periodically converted into wrapped Bitcoin (wBTC)
4. Users can withdraw their principal and accumulated yield at any time

ERN does not introduce additional leverage or rehypothecation beyond the underlying DMMs. The strategy is spot-based and does not rely on leverage, recursive borrowing, or looping positions.

## APY and Yield Calculation

The APY is a **variable rate** derived from the supply and demand mechanics of the third-party lending protocols on Ethereum Mainnet. The platform **updates the "Current APY" hourly**.

Daily earnings are calculated by applying the variable annualized rate to the user's stablecoin principal, pro-rated for the 24-hour period. The yield is automatically **converted into wBTC**. The specific amount of wBTC received depends on both the prevailing lending interest rate and the spot conversion rate between the stablecoin and Bitcoin.

## Fees

| Fee Type | Amount | Notes |
|----------|--------|-------|
| Protocol Fee | 10% of generated yield | Covers gas costs for yield operations |
| Deposit Fee | 0% | - |
| Withdrawal Fee | 0% | Standard withdrawals are free |
| Early Withdrawal Fee | 0.1% | Only during first 48 hours after deposit |

Gas costs for routine yield collection and conversion operations are covered by the protocol and funded through the 10% protocol fee. Users do not pay gas for these operations.

## Safety and Security

### Non-Custodial Architecture

The ERN team **never holds or has access to your funds**. Assets are locked in open-source smart contracts that have been verified through external security audits. No central authority can mismanage, freeze, or steal your deposits. The core vault contracts are immutable.

### Risk Mitigation Measures

- Use of audited, battle-tested DMMs (Aave V3)
- Non-custodial architecture with no admin keys or upgrade functionality
- Ongoing security reviews and bug bounty programmes

## Risks

| Risk Category | Description |
|---------------|-------------|
| Smart Contract Risk | Bugs, vulnerabilities, or unexpected interactions between ERN's contracts and external protocols |
| Underlying Protocol Risk | Smart contract exploits, oracle failures, governance attacks in DMMs |
| Stablecoin Risk | Issuer risk, regulatory risk, potential depegging of USDC/USDT |
| Bitcoin Yield Conversion Risk | Price volatility during conversion, liquidity constraints, wBTC token model |
| Oracle and Pricing Risk | Incorrect, delayed, or manipulated price data affecting conversions |
| Ethereum Network Risk | Network congestion, high gas fees, consensus failures |

## Why wBTC and Not Native Bitcoin?

ERN operates on the Ethereum Mainnet. wBTC (Wrapped Bitcoin) is the standard ERC-20 representation of Bitcoin. Users can bridge wBTC to native Bitcoin using third-party bridges or centralized exchanges at any time.

## ERN Token

**ERN does not have a governance token.** Be wary of any "airdrop" claims or tokens claiming to be associated with ERN.

## Share & Earn Programme

ERN's referral programme allows users to earn a portion of the protocol's fees by inviting others.

- **Referral rate:** 10% of referred users' yield
- **Paid by:** Protocol fees (referred users keep 100% of their displayed yield)
- **Distribution:** Weekly
- **Withdrawals:** Anytime
- **Caps:** None

**Example:** A referred user generates $100 in yield. You receive $10. The referred user still receives the full $100.

## Account Management

### Checking Your Balance

Connect your Ethereum-compatible wallet (MetaMask, Rabby, etc.) to the ERN application dashboard to view:
- Current stablecoin deposit
- Total accrued Bitcoin (wBTC) earnings in real-time

### Client Support

1. **Live Chat:** Help icon in the lower right-hand corner of the website
2. **Email Ticket:** "Submit a request" button (response within 72 working hours)
3. **Telegram:** [t.me/ernofficial](https://t.me/ernofficial)

### Safety Warnings

- ERN will **NEVER** ask for your Seed Phrase or Private Key
- Admins will **never** DM you first
- Always verify you are on `ern.app` — scammers buy Google ads with fake URLs
- Never "validate your wallet" or input your private key on a random website

## Smart Contracts

- **Ethereum Mainnet (ernUSDT):** `0x87f0e6f65ccf64d6d504c9db95f390d2acb033b5`
- **Ethereum Mainnet (ernUSDC):** `0x226455A82E30Ff05E68B37b99C59e503104bA84B`
- **RewardsDistributor:** `0x9f76037494092aceac5b23e21c20b1970a866ef5`

## Official Resources

| Resource | Link |
|----------|------|
| X (Twitter) | [x.com/ernapp](https://x.com/ernapp) |
| Telegram | [t.me/ernofficial](https://t.me/ernofficial) |
| GitHub | [github.com/ernorg/ern](https://github.com/ernorg/ern) |
| Audits | [ernorg/ern/audits](https://github.com/ernorg/ern/tree/main/audits) |
| Dune Analytics | [dune.com/ern/ern](https://dune.com/ern/ern) |
| Terms | [ern.app/terms](https://ern.app/terms) |
| Privacy Policy | [ern.app/privacy-policy](https://ern.app/privacy-policy) |
