---
title: "MEV & DEX 套利"
weight: 6
bookCollapseSection: true
---

---


**原理**：在去中心化交易所（Uniswap、Sushi、PancakeSwap、Raydium 等）之间或与 CEX 之间，因同一资产在不同池子的价格差异，执行原子交易（atomic arbitrage）套利。常配合 **Flash Loan**（闪电贷）实现 0 本金套利。

**MEV（Maximal Extractable Value）**：区块生产者（验证者 / 排序器）通过重新排序、插入、审查交易提取价值。套利是 MEV 的最大类别。

## 推荐

| Repo | ★ | 链 | 说明 |
|------|---|----|------|
| [x89/Solana-Arbitrage-Bot](https://github.com/x89/Solana-Arbitrage-Bot) | 1174 | Solana | star 最多但作者 spam Telegram 推广，**谨慎**评估代码质量 |
| [fuzzland/sui-mev](https://github.com/fuzzland/sui-mev) | 774 | Sui | Sui 链 MEV |
| [solidquant/mev-templates](https://github.com/solidquant/mev-templates) | 576 | 多链 | Python/JS/Rust 模板，覆盖广 |
| [flashbots/mev-inspect-rs](https://github.com/flashbots/mev-inspect-rs) | 560 | Ethereum | **Flashbots 官方**，分析历史 MEV 数据，**不交易**，适合学习 |
| [BowTiedDevil/degenbot](https://github.com/BowTiedDevil/degenbot) | 549 | EVM | Uniswap V2/V3/V4 + Curve 基础库（Python + Rust via PyO3） |
| [0xfnzero/sol-trade-sdk](https://github.com/0xfnzero/sol-trade-sdk) | 324 | Solana | Rust 低延迟 SDK |
| [sorasuzukidev/ethereum-bnb-mev-bot](https://github.com/sorasuzukidev/ethereum-bnb-mev-bot) | 366 | EVM + BSC | 双链 MEV |

## 主流框架

| 框架 | 链 | 说明 |
|------|----|------|
| [Flashbots](https://github.com/flashbots) 组织 | Ethereum | MEV 生态核心，提供 MEV-Protect、SUAVE、Builder |
| [EigenPhi](https://eigenphi.io/) | 多链 | MEV 数据可视化（不开源） |
| [ArbitraryExecution](https://github.com/pcaversaccio) | EVM | 套利执行层 |

## 学习路径

1. 先看 **flashbots/mev-inspect-rs**，理解 MEV 数据结构
2. 用 **BowTiedDevil/degenbot** 在本地 fork 模拟器跑回测
3. 真实上链前，先在 **goerli / sepolia** testnet 跑通
4. 最后才是主网，**预算严格控制**（gas 一次失败就几十美金）

## 关键风险

- **Gas 战争**：高峰期一笔失败交易几十美金
- **Sandwich 攻击**：你的 pending tx 被夹子夹
- **RPC 节点延迟**：落后 100ms 利润全无
- **私钥泄露**：MEV bot 是黑客重点目标
- **监管变化**：美国 OFAC 制裁 Tornado Cash 后，很多 MEV 玩法被讨论是否合规
