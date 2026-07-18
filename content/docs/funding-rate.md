---
title: "Funding Rate 套利"
weight: 2
---


**原理**：永续合约多空双方按 funding rate（每 8h 一次结算）互相付费。同一个币在两个交易所 funding rate 不一致 → 在费率高的交易所做空（或做多），在费率低的交易所反向，方向风险被对冲，每天净赚 funding 差 - 手续费 - 滑点。

典型案例：Hyperliquid BTC funding +0.05%（多头付钱给空头）→ 在 Hyperliquid 做空，Binance 现货买入，BTC 涨跌风险对冲。

## 推荐

| Repo | ★ | 说明 |
|------|---|------|
| [aoki-h-jp/funding-rate-arbitrage](https://github.com/aoki-h-jp/funding-rate-arbitrage) | 303 | **首选入门**。只读分析库（不自动下单），Python 3.11，MIT。支持 Binance / Bybit / OKX / Gate / CoinEx / Bitget。已本地实测可用 |
| [50shadesofgwei/funding-rate-arbitrage](https://github.com/50shadesofgwei/funding-rate-arbitrage) | 181 | Delta-neutral 搜索器 |
| [IrakliXYZ/ARBOT](https://github.com/IrakliXYZ/ARBOT) | 38 | 现货-永续套利 bot |
| [hypurrquant/perp-cli](https://github.com/hypurrquant/perp-cli) | 32 | 多 DEX 永续 CLI + MCP server（Pacifica, Hyperliquid） |
| [supervik/funding-rate-arbitrage-scanner](https://github.com/supervik/funding-rate-arbitrage-scanner) | 27 | 扫描器 |

## aoki-h-jp/funding-rate-arbitrage 用法

```bash
# 安装
python3 -m venv frarb_env
source frarb_env/bin/activate
pip install git+https://github.com/aoki-h-jp/funding-rate-arbitrage

# 验证（需要代理访问被墙的 CEX）
python3 -c "
from funding_rate_arbitrage.frarb import FundingRateArbitrage
fr = FundingRateArbitrage()
fr.display_large_divergence_multi_exchange(display_num=10, sorted_by='revenue')
"
```

输出示例：

```
                binance   bybit       okx  bitget    gate    coinex  Divergence [%]  Commission [%]  Revenue [/100 USDT]
FIL/USDT:USDT -0.004703 -0.0232 -0.334535 -0.0047 -0.0245 -0.737473        0.732773           0.202             0.530773
```

> 这只是分析输出，**不会自动下单**。读到 divergence 后需自己手动开仓。

## 关键提醒

- Funding rate 每 8 小时结算一次（UTC 00:00 / 08:00 / 16:00），需在结算前几分钟两边都开好仓
- 现货 + 永续的对冲，要求两侧 delta、notional 完全一致，否则方向风险没被对冲
- 部分币种（尤其小币）funding rate 短时波动巨大，滑点和撤单成本高