---
title: "Aave V3 闪电贷套利流程"
date: 2026-07-19
---

## 流程

一笔套利 tx 的结构（Aave V3 闪电贷为例）：

```
1. 从 Aave V3 Pool flashLoanSimple 借 1,000,000 USDC
2. 在 Uniswap V3 用 USDC 买 ETH（假设价格低）
3. 在 SushiSwap 卖 ETH 换 USDC（假设价格高）
4. Aave V3 Pool 归还 1,000,000 USDC + 5 bps 利息（500 USDC）
5. 利润留在合约 wallet
```

任何步骤失败 → 整个 tx revert → 不亏 gas。

## Foundry 测试

```solidity
contract ArbTest is Test {
    function testArb() public {
        // fork mainnet at block N
        vm.createSelectFork("mainnet", BLOCK);
        
        // execute
        uint profit = arb.execute(USDC, 1_000_000e6, uniPath, sushiPath);
        assertGt(profit, 0);
    }
}
```

## 上主网 checklist

1. **Gas 预算**：单笔 ≤ 0.02 ETH（gas limit ~500k, gas price 30 gwei）
2. **MEV-Boost**：用 Flashbots private mempool，避免被 sandwich
3. **失败回滚预算**：单日最多 5 次失败，超出走人
4. **Profit threshold**：每笔至少 50 USD 利润才发（gas 摊销）

## 风险

1. **竞争激烈**：机会窗口 < 100ms，bot 比拼速度
2. **MevBlock / 私有池**：不加 private mempool 等于送钱
3. **Aave 利率**：极端行情下 aToken 利率变负，借贷成本上升
4. **合约升级风险**：Aave V3 治理变更可能影响闪电贷接口
