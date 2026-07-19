---
title: "Binance ↔ OKX 资金费率套利实操"
date: 2026-07-19
---

## 背景

Binance 永续 BTC funding rate 经常比 OKX 高 0.01%–0.05%（8h 周期），两边同时开反向仓位即可锁定 funding rate 之差，**delta-neutral**。

## 仓位

- Binance：现货 + U 本位永续空单（吃 funding，付空单资金）
- OKX：U 本位永续空单（两边空单对冲现货风险，或 OKX 吃 funding）

实操中常见组合：

| 腿 | 数量 | 方向 | 备注 |
|----|------|------|------|
| Binance 现货 | 1 BTC | 买 | 锁定 delta |
| Binance 永续 | 1 BTC | 卖空 | 收 funding |
| OKX 永续 | 1 BTC | 卖空 | 对冲永续风险 |

## 收益估算

假设 funding 差 0.03% / 8h：

- 一天 3 期 × 0.03% = 0.09% / 天
- 杠杆 3x → 名义 0.27% / 天
- 月化 ≈ 8%（毛），扣手续费 / 提币 / funding 滑点后净 4–6%

## 风险

1. **强平价**：两边永续 delta 略有差异时，行情急涨/急跌可能爆一边
2. **funding 反转**：当 BTC 单边情绪强，Binance funding 反而比 OKX 低，套利变亏
3. **提币成本**：跨所划转（不走提币的话）一般仅集团内免费，跨集团要 TRC20 / ERC20 gas
4. **API 限频**：高频调仓触发交易所风控

## 推荐实现

- 检测 funding 差 → 开仓：参考 [Funding Rate 套利](../funding-rate/) 主题
- 仓位监控：freqtrade + 自定义策略（每 30s 同步两边账户 delta）
- 风控：单边 delta > 0.1 BTC 立即平仓

## 参考链接

- [Binance 永续 funding 文档](https://www.binance.com/en/futures/funding-history)
- [OKX 永续 funding 文档](https://www.okx.com/futures/funding-rate)
- aoki-h-jp/funding-rate-arbitrage（支持多所监控，见 Funding Rate 主题）