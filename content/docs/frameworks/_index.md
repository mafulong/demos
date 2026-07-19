---
title: "通用交易框架"
weight: 10
bookCollapseSection: true
---

---


不是纯套利 bot，但都支持写套利策略（或可直接用作套利）。star 数高、社区大、文档全、Bug 修复快 — 适合作为套利 bot 的底座。

## 推荐（按 star 排序）

| Repo | ★ | 语言 | 说明 |
|------|---|------|------|
| [freqtrade/freqtrade](https://github.com/freqtrade/freqtrade) | **52410** | Python | **最多 star**。免费开源，含回测 / dry-run / 实盘 / Web UI / Telegram bot。策略用 Python 写 |
| [hummingbot/hummingbot](https://github.com/hummingbot/hummingbot) | 19158 | Python / Cython | 业内最知名做市/套利框架，Hummingbot Foundation 维护。含 pure market making / cross-exchange MM / amm-arb 等内置策略 |
| [jesse-ai/jesse](https://github.com/jesse-ai/jesse) | 8178 | Python | 高级回测（支持多 timeframe、多 symbol）+ 实盘，文档极好 |
| [Drakkar-Software/OctoBot](https://github.com/Drakkar-Software/OctoBot) | 6232 | Python | 含 AI / Grid / DCA / 做市，社区维护 |
| [enarjord/passivbot](https://github.com/enarjord/passivbot) | 2029 | Python | 多交易所网格/做市（Bybit/Bitget/OKX/GateIO/Binance/Kucoin） |

## 选择指南

| 场景 | 推荐 |
|------|------|
| 我只会 Python，想快速上手 | **freqtrade**（文档 + 视频教程最多） |
| 做市策略为主 | **Hummingbot** |
| 高级回测 + 实盘切换 | **jesse** |
| 想要 Grid / DCA 等多策略 | **OctoBot** |
| 只想跑永续网格 | **passivbot** |

## freqtrade 入门

```bash
# 安装（macOS）
git clone https://github.com/freqtrade/freqtrade
cd freqtrade
./setup.sh -i  # 交互式安装

# 启动 dry-run（模拟盘，不花钱）
freqtrade trade --strategy SampleStrategy --config user_data/config.json --dry-run

# 跑回测
freqtrade backtesting --strategy SampleStrategy --config user_data/config.json \
    --timerange 20240101-20240701
```

## Hummingbot 入门

```bash
git clone https://github.com/hummingbot/hummingbot
cd hummingbot
./install
./start   # 启动 CLI

# 在交互式 prompt 里配置 exchange + 策略
```

## jesse 入门

```bash
pip install jesse
jesse make-route  # 建项目骨架
# 编辑 strategies/ 写策略
jesse backtest  # 回测
jesse live      # 实盘
```

## 该主题文章

- [freqtrade 跑 funding rate 策略](2026-07-19-freqtrade-funding-strategy/)
