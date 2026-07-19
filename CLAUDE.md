# demos 站点

Hugo (hugo-book) 静态站点，部署到 GitHub Pages 的 `gh-pages` 分支，自定义域名 `mafulong.eu.org`。
线上地址：<https://mafulong.eu.org/demos/>
源码：<https://github.com/mafulong/demos>

## 内容发布

发布任何内容到本站点，**必须**调用 `publish-demo` skill（位于 `~/.claude/skills/publish-demo/SKILL.md`）。

- ❌ 不要直接编辑 `content/docs/`
- ❌ 不要自己跑 `hugo` 或 `git push`
- ❌ 不要绕过 skill 的交互式确认

✅ skill 会自动处理：主题校验、文件名生成、frontmatter、确认、部署、验证。

## 目录布局

```
content/docs/
├── _index.md                  # 站点首页（weight 1）
├── about/_index.md            # README（weight 2）
└── <topic>/                   # 一个套利主题一个目录
    ├── _index.md              # 该主题的主文章（原理 + 推荐项目 + 关键考虑）
    └── YYYY-MM-DD-<slug>.md   # 该主题下的具体实操/案例文章（可选，0 或多个）
```

**关键约定**：
- 每个主题的 `_index.md` = 主文章本身，含该主题的核心内容（不是导航页）。
- 日期子文件 = 主文章下面的具体实操/案例笔记。
- 主文章 frontmatter：`title` + `weight` + `bookCollapseSection: true`
- 日期子文件 frontmatter：只有 `title` + `date`，**不要写 `weight`**
- slug 必须是 ASCII kebab-case
- 同一主题下多个日期文件按 date 倒序
- 主文章末尾用 `## 该主题文章` 章节列出子文章链接（最新在前）

## 部署

```bash
./deploy.sh
```

- 脚本内部：`hugo --minify --baseURL "/demos/"` → 把 `public/` 强制推送到 `gh-pages`
- 这是 **force-push**，破坏性强，必须先经用户确认
- GitHub Pages 重建约 1 分钟

## 验证

部署完成后用 `curl -sI` 检查目标 URL 是不是 200。重建延迟最多 30s，必要时重试一次。

## 其他

- 主题：`hugo-book`，主题配置（`BookSection = "docs"`、`BookSearch = true`、`BookToc = true`）在 `hugo.toml`
- 新建主题目录时记得在站点 `_index.md` 的目录结构表里加一行
- 现有主题新增笔记时**不需要**改站点 `_index.md`