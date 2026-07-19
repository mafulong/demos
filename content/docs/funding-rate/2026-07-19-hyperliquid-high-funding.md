---
title: "Hyperliquid 高 funding 实操"
date: 2026-07-19
---

## 现象

Hyperliquid BTC 永续 funding rate 经常比 Binance 高 0.05%–0.15%（8h），散户 + 早期项目方在 Hyperliquid 上做多为主，长期处于净付 funding 状态。

## 套利组合

| 腿 | 平台 | 方向 | 数量 |
|----|------|------|------|
| 1 | Binance 现货 | 买 | 1 BTC |
| 2 | Binance 永续 | 卖空 | 1 BTC |
| 3 | Hyperliquid 永续 | 卖空 | 1 BTC |

腿 2 + 腿 3 完全对冲永续 delta；腿 1 锁定现货 delta。**净持仓 = 0 delta**，吃 funding 差。

## 收益

假设 Hyperliquid 比 Binance funding 高 0.10% / 8h：

- 一天 3 期 × 0.10% = 0.30% / 天
- 3x 杠杆 → 名义 0.9% / 天
- 月化 ≈ 27%（毛），扣两边手续费 ~0.04% / 天 → 净 ~25%

## 风险

1. **Hyperliquid funding 反转**：情绪反转时 funding 跌到负数甚至比 Binance 还低
2. **强平价差**：Hyperliquid 标记价机制和 Binance 不完全同步，急涨/急跌可能爆一边
3. **提币 / 划转**：现货在 Binance，永续在 Hyperliquid，无套保关系，全靠 funding 差支撑
4. **API 限频**：Hyperliquid 私钥签名，调用频率过高触发风控

## 实现

- Hyperliquid 官方 [Python SDK](https://github.com/hyperliquid-dex/hyperliquid-python-sdk)
- funding 监控 + 下单逻辑：参考 aoki-h-jp/funding-rate-arbitrage（支持 Hyperliquid）
- 风控脚本：freqtrade 策略 + 自定义仓位监控
