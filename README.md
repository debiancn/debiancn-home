# debian社区首页 网页

1. 一个网页，两个简单页面归并到首页，点击菜单进行切换 
2. 预计划自动更新debain新闻（待完成）和安全通知（已完成，由服务器上 "repo" 这个 docker 实例提供支持）
3. 不需要放在网站上的页面会归并到 *_temp* 文件夹中
4. `<a href="#">...</a>` 会导致页面刷新，显示效果为跳转到页面顶部，现在以 `<a href="javascript:;">...</a>` 来代替,可以显示链接效果，但是不会跳转, 并且设置样式为充满整个块级元素
5. 响应式布局，兼容大多数浏览设备分辨率，如果发现排版错误请通知我

## 自动更新实现流程

通过 `debiancn/debiancn.org` 仓库的 GitHub Action 实现自动更新。

通过定时计划每天 UTC 23:00 自动更新。

触发时拉取本仓库代码，并运行 `make` 命令，进行 XSLT 自动生成 `index.html` 文件，并将 `index.html` 和 `privacy-terms.html` 文件更新到 `debiancn/debiancn.org` 仓库，从而实现主页更新。

未来的首页开发应当直接编辑 `index.xsl` 文件，按照 XHTML 标准书写页面即可。

## License

GPL-3+
