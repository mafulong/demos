---
title: "freqtrade 跑 funding rate 策略"
date: 2026-07-19
---

## 为什么选 freqtrade

- star 数最多（>50k），bug 修得快
- 策略用 Python 写，可读性好
- 自带 dry-run / 回测 / 监控 / Telegram 通知
- 支持多个 CEX 的永续合约（通过 CCXT）

## 安装

```bash
git clone https://github.com/freqtrade/freqtrade
cd freqtrade
./setup.sh -i
```

## 最小 funding rate 策略

```python
from freqtrade.strategy import IStrategy
import ccxt

class FundingRateArb(IStrategy):
    timeframe = '5m'
    
    def populate_indicators(self, dataframe, metadata):
        # 拉 funding rate
        exchange = ccxt.binance({'options': {'defaultType': 'future'}})
        funding = exchange.fetch_funding_rate(metadata['pair'])
        dataframe['funding'] = funding['fundingRate']
        return dataframe
    
    def populate_entry_trend(self, dataframe, metadata):
        # funding > 阈值 → 做空吃 funding
        dataframe.loc[dataframe['funding'] > 0.0005, 'enter_short'] = 1
        return dataframe
    
    def populate_exit_trend(self, dataframe, metadata):
        dataframe.loc[dataframe['funding'] < 0.0001, 'exit_short'] = 1
        return dataframe
```

## 跑起来

```bash
freqtrade trade \
  --strategy FundingRateArb \
  --config user_data/config_binance.json \
  --dry-run  # 先模拟盘
```

## 局限

- freqtrade 默认 **不支持 cross-exchange 套利**（策略只看单个 timeframe）
- 跨所 funding 套利需自写监控 + 下单逻辑，或用 [aoki-h-jp/funding-rate-arbitrage](../../funding-rate/)
- 现货 + 永续对冲也是手写，freqtrade 不内置 delta-neutral
