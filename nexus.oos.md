# Out of Scope

## Known Issues / Accepted Risks

- No known issues listed by the team.

## In-Scope Impacts (Smart Contracts Only)

Only the following attack impacts are eligible:

**Critical ($11k-$50k, 10% of affected funds):**
- Direct theft of user funds (at-rest or in-motion, excluding unclaimed yield)
- Permanent freezing of funds
- Protocol insolvency

**High ($3k-$10k):**
- Theft of unclaimed yield
- Permanent freezing of unclaimed yield
- Temporary freezing of funds

**Medium ($2k fixed):**
- Smart contract unable to operate due to lack of token funds
- Block stuffing
- Griefing (damage without profit motive)
- Theft of gas
- Unbounded gas consumption

**Low ($1k fixed):**
- Contract fails to deliver promised returns without losing value

## Out of Scope: Everything Else

Any impact or vulnerability type not listed above is out of scope, including but not limited to:

- Centralization / admin key risks (trusted roles)
- Third-party / external protocol issues (Aave V3, Uniswap V3, OpenZeppelin)
- Oracle data supplied by third parties (excludes oracle manipulation / flash loan attacks)
- Economic / governance attacks (51% attacks)
- Liquidity impacts
- Sybil attacks
- Stablecoin depeg attacks (where attacker didn't cause the depeg)
- Self-exploited impacts causing damage to the attacker only
- Attacks using leaked credentials or privileged addresses
- Phishing or social engineering
- Best practice / informational findings
- Gas optimization issues
- Issues in test or configuration files
- Denial of service without fund impact

## Program Rules

- PoC required for all severities
- Testing on local forks only (no mainnet/testnet interaction)
- No testing with pricing oracles or third-party contracts directly
- Repeatable attacks: first attack counts 100%, subsequent attacks reduced 25% per 300 blocks
- KYC required for reward payout
- Payments in USDC on Ethereum
