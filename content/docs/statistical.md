---
title: "统计套利"
weight: 6
---


**原理**：找出两个历史上价格走势高度相关的资产（比如 ETH/BTC 和 stETH/ETH），当两者价差（spread）偏离历史均值超过 N 个标准差时，做多便宜方、做空贵方，等价差回归获利。

**优势**：和方向无关，市场中性，熊市也能赚
**劣势**：需要足够长的历史数据（cointegration 测试）、严格的回测、手续费优化

## 推荐

| Repo | ★ | 说明 |
|------|---|------|
| [hzjken/crypto-arbitrage-framework](https://github.com/hzjken/crypto-arbitrage-framework) | 704 | ccxt + cplex（数学优化），学术派 |
| [fraserjohnstone/pairs-trading-backtest-system](https://github.com/fraserjohnstone/pairs-trading-backtest-system) | 23 | 回测框架，Python |
| [Hudie/crypto_algo_trading](https://github.com/Hudie/crypto_algo_trading) | 56 | 综合量化框架，含配对交易 |

## 通用工具（非 crypto 专用，但配对交易核心）

- **statsmodels**（Python）：协整检验（coint）、ADF
- **arch**（Python）：GARCH 波动率建模
- **pyflux**：时间序列
- **jesse-ai/jesse**（8k★）：高级回测 + 实盘

## 经典流程

1. **选 pair**：用日线 / 小时线做 cointegration test（p < 0.05 算稳）
2. **建模 spread**：用 OLS / Kalman filter 计算动态对冲比
3. **阈值**：用 z-score 计算偏离，|z| > 2 开仓，|z| < 0.5 平仓
4. **回测**：用 jesse 或 backtrader，**严防 lookahead bias**
5. **风控**：单笔最大亏损、pair 协整关系破裂时的退出

## 注意

- 加密资产协整关系可能因结构性事件（合并、分叉、暴雷）突然失效
- 历史数据要包含熊市段（不然回测在牛市中过拟合）
- 杠杆放大收益也放大亏损，单边爆仓就 game over