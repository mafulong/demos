---
title: "三角套利"
weight: 4
bookCollapseSection: true
---

---


**原理**：同一交易所内，3 个交易对之间的价格不一致。比如 BTC/USDT、ETH/BTC、ETH/USDT 三个市场价不严格满足 `BTC/USDT × ETH/BTC ≈ ETH/USDT`，差值就是机会。

**现实**：理论收益 0.1%-0.3%，已被 HFT 挤到 < 0.01%，需要极低延迟 + 充足手续费优惠（maker rebate）。

## 推荐

| Repo | ★ | 说明 |
|------|---|------|
| [Roibal/Cryptocurrency-Trading-Bots-Python-Beginner-Advance](https://github.com/Roibal/Cryptocurrency-Trading-Bots-Python-Beginner-Advance) | 1437 | 综合教程，含三角套利（入门+进阶） |
| [ericjang/cryptocurrency_arbitrage](https://github.com/ericjang/cryptocurrency_arbitrage) | 859 | pairwise + 三角都有，检测型 |
| [kelvinau/crypto-arbitrage](https://github.com/kelvinau/crypto-arbitrage) | 846 | 自动三角 / 跨所，文档全 |
| [zlq4863947/triangular-arbitrage](https://github.com/zlq4863947/triangular-arbitrage) | 671 | 中文 README，国内作者 |
| [tiagosiebler/TriangularArbitrage](https://github.com/tiagosiebler/TriangularArbitrage) | 619 | 只检测机会，不下单 |
| [eugenioclrc/binance-crypto-triangular-arbitrage](https://github.com/eugenioclrc/binance-crypto-triangular-arbitrage) | 290 | Binance 专项，盈利 finder |
| [karthik947/BinanceTriangularArbitrage_v2](https://github.com/karthik947/BinanceTriangularArbitrage_v2) | 268 | 新版 |

## 主流模式对比

| 模式 | 含义 |
|------|------|
| 检测型（detect-only） | 只输出机会列表，适合研究 |
| 半自动（semi-auto） | 检测 + 一键下单 |
| 全自动（full-auto） | 持续运行 + 风控 |

**新手建议**：先用检测型工具（如 tiagosiebler/TriangularArbitrage）观察一两周，看机会频率和真实收益，再决定要不要自动。
