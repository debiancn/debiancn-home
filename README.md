# Debian 中文社区首页

Debian 中文社区（<https://www.debiancn.org/>）的首页源码。页面通过 XSLT 将 XML 内容渲染为静态 HTML，新闻与安全更新由 RSS 自动生成。

## 特性

- **现代化视觉**：卡片式布局、流体排版（`clamp()`）、CSS Grid、柔和阴影与品牌色阶。
- **响应式**：移动端折叠菜单、流式布局、安全区适配（`env(safe-area-inset-*)`）。
- **日夜模式**：跟随系统 `prefers-color-scheme`，并提供手动切换按钮；选择保存在 `localStorage`。
- **现代浏览器能力**：CSS 自定义属性、`color-scheme`、`backdrop-filter`、`:focus-visible`、`prefers-reduced-motion`、`prefers-contrast`、`<time>` 语义化日期。
- **全仓库软件包搜索**：软件源页导航栏支持按包名搜索全部社区仓库，结果来自站点的 `/info/*.json`，选中后跳转到包所在目录；索引在 `localStorage` 中缓存 12 小时。
- **可访问性**：跳转链接、ARIA 状态、键盘可达、足够的颜色对比度。
- **无外部依赖**：不依赖 CDN 或第三方 CSS/JS，可完全离线构建。

## 目录结构

```
.
├── index.xml            # 首页内容
├── repo.xml             # 软件源页面内容
├── privacy-terms.xml    # 隐私政策与服务条款
├── templates/
│   ├── framework.xsl    # 页面框架（head / 页头 / 导航 / 页脚）
│   └── index.xsl        # 首页 RSS 渲染
├── css/
│   ├── base.css         # 设计令牌、重置、布局、页头、导航、页脚、主题
│   ├── index.css        # 首页样式
│   ├── repo.css         # 软件源页样式
│   └── github-corner.css
├── js/
│   ├── theme.js         # 日夜模式切换
│   ├── navbar.js        # 移动端菜单
│   ├── repo.js          # 软件源页：文件列表 + 软件包搜索
│   └── tab.js           # 首页标签页
├── images/              # Logo、图标与 favicon
└── rss/                 # 构建时自动下载的 RSS 源（不纳入版本库）
```

## 构建

需要 `xsltproc`、`wget` 与 GNU `make`：

```sh
make
```

生成的 `index.html`、`repo.html`、`privacy-terms.html` 默认使用相对路径（`STATIC_ROOT=.`）。若需部署到静态子目录，可指定 `STATIC_ROOT`：

```sh
make STATIC_ROOT=static.debiancn.org
```

本地预览：

```sh
python3 -m http.server 8000
# 打开 http://127.0.0.1:8000/index.html
```

## 自动更新

通过 `debiancn/debiancn.org` 仓库的 GitHub Action 实现自动更新：每天 UTC 23:00 拉取本仓库代码并运行 `make`，把生成的 `index.html` 与 `privacy-terms.html` 推送至网站仓库。

-  Debian 新闻：<https://www.debian.org/News/news>
- 安全公告：<https://www.debian.org/security/dsa>
- 社区论坛新闻：<https://forums.debiancn.org/c/5-category.rss>

## 软件包搜索

软件源页导航栏的搜索框会按包名搜索社区仓库中的全部软件包。数据来自站点上已经存在的 JSON 索引：

```
/info/trixie.json
/info/bookworm.json
/info/bullseye.json
```

这些文件由仓库服务器上的 `custodian` 定时生成（结构为 `{"main": {"amd64": [...]}}`）。前端首次搜索时才加载，按包名去重后只保留“包名 → 目录”，并缓存到 `localStorage`（键名 `debiancn-repo-search-v1`，有效期 12 小时）。搜索结果选中后跳转到 `pool/main/...` 下对应的包目录，`-dbgsym`/`-dbg` 调试包会被隐藏。

新增发行版代号时，需要同步更新 `js/repo.js` 顶部的 `INDEX_URLS`。站点外的本地预览没有 `/info/*.json`，搜索会提示“全仓库搜索暂不可用”。

## 主题

页面默认跟随操作系统的深浅色设置。点击页头右侧的太阳/月亮按钮可手动切换，选择会写入 `localStorage`（键名 `debiancn-theme`），下次访问时生效。

## License

GPL-3+
