---
source: https://docs.ern.app/en/articles/2455199-what-are-decentralized-money-markets-dmms
crawled_at: 2026-03-10T12:56:19.936016
---

**Decentralized Money Markets (DMMs)** are on-chain financial protocols that allow users to lend, borrow, and earn yield on digital assets **without relying on intermediaries** such as banks or custodians. These systems are implemented entirely through smart contracts and operate in a transparent, permissionless manner.

Ern leverages DMMs as the core infrastructure for generating yield on deposited stablecoins.

* * *

### **How Decentralized Money Markets (DMMs) work**

At a high level, DMMs connect **suppliers of capital** with **borrowers** through smart contracts:

- **Lenders** deposit assets (such as stablecoins) into shared liquidity pools

- **Borrowers** take loans from these pools by providing collateral

- **Interest rates** are set algorithmically based on supply and demand

- **Interest paid by borrowers** is distributed proportionally to lenders


All balances, interest calculations, and liquidations are enforced automatically on-chain.

* * *

### **Key characteristics of DMMs**

#### **Non-custodial by design**

DMMs are non-custodial. Users retain control of their funds at all times, with assets held in smart contracts rather than by a central operator.

#### **Transparent and verifiable**

All activity within DMMs is publicly verifiable on-chain, including deposits, borrows, interest rate models, and liquidation events.

#### **Algorithmic interest rates**

Interest rates in DMMs adjust dynamically based on market conditions. Higher borrowing demand generally leads to higher yields for lenders, and vice versa.

#### **Permissionless access**

Anyone with a compatible wallet can interact with DMMs in a transparent and direct way. Instantly and with no intermediaries.

* * *

### **Collateral and liquidations in DMMs**

Borrowers in DMMs must post collateral that exceeds the value of their loan. If the collateral value falls below protocol-defined thresholds, positions may be automatically liquidated to protect lenders.

This mechanism helps maintain solvency but can introduce liquidation risk during periods of high market volatility.

* * *

### **Battle-tested DMMs**

Several DMMs have been operating in production for years and secure billions of dollars in on-chain liquidity. Ern integrates with established DMMs such as **Aave v3**, which have undergone extensive auditing, real-world usage, and stress testing.

* * *

### **How Ern uses Decentralized Money Markets (DMMs)**

When users deposit stablecoins into Ern:

1. Funds are supplied to DMMs on **Ethereum**

2. Deposited capital earns interest from borrowers within the DMM

3. Earned yield is periodically converted into wrapped Bitcoin (wBTC)

4. Users can withdraw their principal and accumulated yield at any time


Ern does not introduce additional leverage or rehypothecation beyond the underlying DMMs.