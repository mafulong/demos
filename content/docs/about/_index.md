---
title: "关于本站"
weight: 2
---

## 这是什么

本站是 **Crypto 套利开源项目梳理** 的公开笔记，基于 [Hugo](https://gohugo.io/) + [hugo-book](https://github.com/alex-shpak/hugo-book) 主题，托管在 GitHub Pages（`gh-pages` 分支），自定义域名 <https://mafulong.eu.org/demos/>。

源仓库：<https://github.com/mafulong/demos>

## 内容组织

- 每个套利主题一个目录（如 `funding-rate/`），目录下每篇笔记按日期命名 `YYYY-MM-DD-<slug>.md`，同一主题多篇按日期倒序，互不覆盖。
- 左侧边栏按主题分组折叠；顶部全文搜索；每页右侧目录（TOC）。
- 内容聚焦**开源项目**与**可执行策略**，star 数、活跃度、维护情况是核心筛选维度。

## 如何发布内容

内容通过 Claude Code 的 **publish-demo** 技能发布，**不直接**手动改 `content/docs/`：

1. 向 Claude 提供主题（如 `funding-rate`）和笔记正文（Markdown）。
2. Claude 生成带日期的文件名与 frontmatter，并**在发布前请你确认**（不会未经确认就 push）。
3. 确认后自动构建推送到 `gh-pages`，约 1 分钟后线上生效。

底层由 `deploy.sh` 完成（`hugo --minify` → 强制推送 gh-pages 分支）。该 force-push 是破坏性的，所以发布前必须有用户确认。

## 注意事项

- **不构成投资建议**。本站列出的项目与策略仅为开源生态梳理，实盘有风险，盈亏自负。
- 部分项目 star 数低、未经生产验证，**不要直接拿真钱跑**。
- 项目调研时点是过去某日，**star / 维护状态可能已变化**，使用前请自行核实。