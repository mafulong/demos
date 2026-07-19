---
title: "年化 10% 的话，哪种套利最可行"
date: 2026-07-19
---

> 这是一篇个人判断 + 数据汇总（基于 2026 年 7 月可查到的资料），不是投资建议。

## 一句话结论

**Funding Rate 套利（特别是 Hyperliquid ↔ Binance）** 是个人玩家年化 10% 最稳的路径。其他套利要么被机构挤光、要么需要极低延迟、要么资金量门槛过高。

## 各套利类型当前可行性

| 类型 | 个人玩家年化 | 资金要求 | 难度 | 主要风险 | 当前可行性 |
|------|--------------|----------|------|----------|------------|
| **Funding Rate（CEX 内 delta-neutral）** | 10–25% 毛 / 3–15% 净 | ≥ $10k | 低 | 强平 + funding 反转 | ⭐⭐⭐⭐ |
| **Funding Rate（Hyperliquid ↔ Binance）** | 15–40% 毛 / 8–25% 净 | ≥ $5k | 低-中 | 同上 + 私钥风险 | ⭐⭐⭐⭐⭐ |
| **跨所现货搬砖** | < 5% | ≥ $50k | 中 | 提币延迟 + 风控 | ⭐ |
| **三角套利（同所）** | < 3% | ≥ $20k | 中 | 滑点 | ⭐ |
| **做市（个人）** | 5–15% 净（量小） | ≥ $50k | 极高 | inventory + latency | ⭐⭐ |
| **MEV / DEX 套利** | 难量化 | ≥ $50k gas 预算 | 极高 | 三明治 + 抢单 | ⭐⭐ |
| **统计套利 / Pairs** | 5–20%（策略敏感） | ≥ $100k | 高 | 模型失效 | ⭐⭐⭐ |
| **闪电贷套利** | 单笔偶发 | 0 本金 | 极高 | gas + 抢单 | ⭐⭐ |
| **CEX-DEX 套利** | 难量化 | ≥ $20k | 高 | 提币 + gas | ⭐ |

## 为什么 Funding Rate 套利是首选

### 1. 收益来源稳定

Funding rate 不是"价差收敛"那种零和博弈，是**空头和多头互相付费**，每 8h（或 1h）自然结算。Hyperliquid 因为散户多 + **1 小时结算一次**（比 CEX 的 8h 频繁 8 倍），BTC funding 经常比 Binance 高 0.05–0.15%。

### 2. 风险可对冲

Delta-neutral = 两边仓位互相抵消。只要 funding 差 > 0 就赚钱，不赌方向。

### 3. 个人玩家有空间

跨所 funding 套利窗口 < 1 秒，机构嫌资金利用率低不愿做。**这正好是散户的甜区**。

### 4. 年化 10% 是底线

- 保守情形：Hyperliquid 比 Binance 高 0.03% / 8h → 月化 2.7% → **年化 ~32%**
- 实际扣手续费 + 偶尔反转 → 净 10–20%
- 3x 杠杆后年化 **10% 几乎是下限**

### 5. 工具成熟

- [aoki-h-jp/funding-rate-arbitrage](https://github.com/aoki-h-jp/funding-rate-arbitrage)：多所 funding 监控 + 模拟
- [freqtrade](https://github.com/freqtrade/freqtrade)：策略 + 下单 + dry-run
- [hyperliquid-dex/hyperliquid-python-sdk](https://github.com/hyperliquid-dex/hyperliquid-python-sdk)：Hyperliquid 官方 SDK

## 实操路径（最快上手）

### Step 1：开户 + 资金分散

- Binance 永续账户：放 $5k+
- Hyperliquid 永续账户：放 $5k+（私钥管理好）
- 两边都开 API（或私钥签名）

### Step 2：监控 funding 差

用 aoki-h-jp/funding-rate-arbitrage 监控 BTC/ETH funding 差：

```bash
# 安装
git clone https://github.com/aoki-h-jp/funding-rate-arbitrage
cd funding-rate-arbitrage
pip install -r requirements.txt

# 配置：config.yaml 里填 Binance + Hyperliquid 的 API key
# 启动
python run.py --config config.yaml
```

输出示例：

```
[2026-07-19 08:00:00] BTC funding diff:
  Binance:    0.0100% / 8h
  Hyperliquid: 0.0600% / 8h
  DIFF:       0.0500% / 8h  ← 开仓信号
```

### Step 3：开仓

funding 差 > 0.05% / 8h 时开仓：

| 腿 | 平台 | 方向 | 数量 |
|----|------|------|------|
| 1 | Binance 永续 | 卖空 | 1 BTC |
| 2 | Hyperliquid 永续 | 卖空 | 1 BTC |

（如果 Binance funding 反而更高，就反过来：两边都做多）

### Step 4：风控

- 单边 delta > 0.1 BTC 立即平仓
- funding 差 < 0 时止损
- 单日亏损 > 2% 时强制休息

## 其他套利为什么不推荐

### 跨所现货搬砖

- 5–30 分钟提币延迟让 99% 的机会消失
- 已被做市商 + 量化机构挤光

### 三角套利（同所）

- 同一交易所内 3 对货币价差，机构 latency < 1ms 已经吃完
- 个人滑点直接吃掉利润

### 做市

- 个人 latency 比不过 Citadel/Wintermute
- inventory risk 极高（突然单边行情爆仓）

### MEV / DEX 套利

- 需要 24/7 服务器 + Flashbots private mempool
- 抢单算法比不过专业团队
- 监管风险（OFAC 制裁 Tornado Cash 之后类似工具有争议）

### 统计套利 / Pairs Trading

- 模型失效风险（crypto 相关结构会变）
- 资金量门槛高（≥ $100k 才能分散）
- 需要很强的 quant 背景

## 关键提醒

1. **年化 10% 是毛**，扣 gas / 手续费 / slippage 后净 5–8% 才现实
2. **funding 反转**：单边情绪强时 Hyperliquid funding 可能变负，套利变亏
3. **强平风险**：两边 delta 略有差异时，急涨急跌可能爆一边
4. **API 限频 + 私钥管理**：Hyperliquid 用私钥签名，私钥泄露 = 资金全丢
5. **小金额先跑**：建议 $1k 起跑通流程，再加仓到 $5k+

## 参考资料

- [Beyond the Boredom: My Foray into Hyperliquid Funding Rate Arbitrage](https://medium.com/@Progressive_Crypto/beyond-the-boredom-my-foray-into-hyperliquid-funding-rate-arbitrage-cb6d31fa2832)
- [Risk-Managed Funding Rate Arbitrage on Hyperliquid](https://medium.com/@Progressive_Crypto/risk-managed-funding-rate-arbitrage-on-hyperliquid-stop-out-at-1-move-b1dabf7cf85f)
- [Funding Rate Arbitrage on Hyperliquid for Retail Traders](https://www.binance.com/en/square/post/3174213)
- [Crypto Arbitrage Profitability 2025-2026 (AInvest)](https://www.ainvest.com/news/crypto-arbitrage-profitability-2025-2026/)
- [Crypto Quant: Funding Rate vs Market Making vs Triangular](https://medium.com/@brycegch/crypto-quant-1)
- [aoki-h-jp/funding-rate-arbitrage](https://github.com/aoki-h-jp/funding-rate-arbitrage)
- [freqtrade/freqtrade](https://github.com/freqtrade/freqtrade)
- [hyperliquid-dex/hyperliquid-python-sdk](https://github.com/hyperliquid-dex/hyperliquid-python-sdk)