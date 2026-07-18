---
title: "CEX-DEX 套利"
weight: 11
---


**原理**：同一个币在 CEX 和 DEX 上的价格不一致时，在便宜方买入、贵方卖出赚价差。链下（CEX）vs 链上（DEX）的资金流转是主要瓶颈。

**现实**：
- 链上 gas 成本（尤其以太坊主网）让小金额套利无利可图
- 提币到 DEX / 从 DEX 提回 CEX 的延迟（5-30 分钟）让大多数机会消失
- 主要剩 3 种可执行场景：
  1. **大币 + L2 / Solana**：gas 低
  2. **CEX 内部套利**（如 Binance ↔ Binance.US 在某些时段）
  3. **CEX → 跨链桥 → DEX**：但延迟太久

## 搜索结果

GitHub 上专门的 CEX-DEX 套利 bot star 数普遍 < 10，新项目多。原因：这类策略大多是专业做市商（Wintermute / Wintermute / Alameda 旧团队）在做，**没动力开源**。

可参考但不建议直接用的：

| Repo | ★ | 说明 |
|------|---|------|
| [mkbeh/arb-bot-rs](https://github.com/mkbeh/arb-bot-rs) | 5 | HFT 引擎，CEX + DEX |
| [aitradingbotspro/cross-exchange-ai-arbitrage-trading-bot](https://github.com/aitradingbotspro/cross-exchange-ai-arbitrage-trading-bot) | 2 | AI 增强版 |
| [Pridecliflourish/Hyperliquid-MEV-Arbitrage](https://github.com/Pridecliflourish/Hyperliquid-MEV-Arbitrage) | 1 | Hyperliquid 跨 CEX/DEX |

> 注：star < 10 的项目多半早期且未经生产验证。**不要直接拿真钱跑**。

## 实际可行的 CEX-DEX 策略

### 1. 充值 / 提现差价监控

CEX 内部 USDT 提现到 ERC20 vs TRC20 的转账费率不同；不同 CEX 间提现费率不同。可以监控费率变化选最优路径（这是「转账成本套利」，不是价格套利）。

### 2. CEX-DEX 期货基差套利

CEX 永续价格 vs DEX 永续价格（如 dYdX、GMX、Perpetual Protocol）的 funding rate 不一致 → funding rate 套利（见 [01-funding-rate.md](01-funding-rate.md)）。

### 3. 跨交易所稳定币套利

USDT 在不同 CEX/DEX 之间偶有 0.1%-0.5% 价差，量大有利可图，但需要：
- 两边充足流动性
- 快速转账通道
- 监控脱锚事件（USDC 曾脱锚到 0.87）

## 推荐替代

如果你真的想做 CEX-DEX 套利，建议自己实现，框架参考：

| 框架 | 用途 |
|------|------|
| **freqtrade**（见 08-frameworks.md） | CEX 侧策略 + 数据 |
| **BowTiedDevil/degenbot**（见 04-mev-dex.md） | DEX 侧 EVM 计算 |
| **ccxt** | 统一 CEX API |
| **web3.py / ethers.py** | DEX 链上交互 |

自己拼的好处：
- 不依赖 unmaintained 第三方 bot
- 完全控制 gas 预算和风控
- 能针对具体交易所 / DEX 优化

## 注意事项

1. **CEX 提现审核**：大额频繁提现可能被风控冻结
2. **DEX 链上失败**：一笔失败的 tx 仍要付 gas
3. **私钥管理**：DEX 侧 bot 一定用独立 wallet，别用主钱包
4. **税务**：CEX/DEX 跨平台转账在很多司法管辖区算 taxable event