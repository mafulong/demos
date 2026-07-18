---
title: "Crypto 套利开源项目梳理"
weight: 1
bookCollapseSection: true
---

## 目录结构

| 文件 | 套利类型 |
|------|----------|
| [01-funding-rate.md](01-funding-rate.md) | 资金费率套利（delta-neutral） |
| [02-triangular.md](02-triangular.md) | 三角套利（同一交易所内 3 对） |
| [03-cross-exchange.md](03-cross-exchange.md) | 跨交易所套利（CEX 之间） |
| [04-mev-dex.md](04-mev-dex.md) | MEV / DEX 套利（链上） |
| [05-statistical.md](05-statistical.md) | 统计套利 / Pairs Trading |
| [06-market-making.md](06-market-making.md) | 做市 / 高频回测 |
| [07-flash-loan.md](07-flash-loan.md) | 闪电贷套利（EVM） |
| [08-frameworks.md](08-frameworks.md) | 通用交易框架（非纯套利） |
| [09-hyperliquid.md](09-hyperliquid.md) | Hyperliquid 专项 |
| [10-cex-dex.md](10-cex-dex.md) | CEX-DEX 套利 |

## 速查：按场景选型

| 场景 | 推荐 |
|------|------|
| 学习原理、看数据 | **aoki-h-jp/funding-rate-arbitrage** + **flashbots/mev-inspect-rs**（看真实链上 MEV） |
| 跑套利 bot | **Hummingbot** 或 **freqtrade**（用户基数大、文档全、bug 修得快） |
| Hyperliquid | fork **freqtrade** 接 Hyperliquid Python SDK，比用现成 bot 安全 |
| 统计 / 量化研究 | **jesse-ai/jesse**（回测质量）+ **nkaz001/hftbacktest**（HFT 回测） |
| 跑回测 / paper trade | **freqtrade** 内置 dry-run 最方便 |

## 通用注意事项

1. **Star 数 ≠ 能赚**。高 star 多半是框架 / 教育项目；实盘跑出 alpha 的 bot 没人会开源
2. **很多 repo 长期不维护**，跑前看 `updated_at` 和 issues
3. **API key 安全**：所有策略用只读 key 起，跑通再加 trade 权限；用 IP 白名单
4. **滑点 / 手续费 / 资金费率结算时差** 是大部分"理论上能赚"策略死掉的原因
5. 任何 bot 上实盘前先在 testnet 或小金额上跑至少一周

## 套利类型概览

| 类型 | 风险 | 资金量 | 难度 | 主流期 |
|------|------|--------|------|--------|
| 资金费率 | 低（delta-neutral） | 中-大 | 低 | 持续 |
| 三角 | 中 | 中 | 低 | 弱（已被量化挤满） |
| 跨所现货 | 中-高 | 中 | 中 | 弱 |
| MEV / DEX | 高 | 小-中 | 高 | 持续 |
| 统计 pairs | 低-中 | 大 | 高 | 持续 |
| 做市 | 中 | 大 | 极高 | 持续 |
| 闪电贷 | 高 | 0（无成本） | 高 | 监管变化 |