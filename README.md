# debian社区首页 网页

1. 一个网页，两个简单页面归并到首页，点击菜单进行切换 
2. 预计划自动更新debain新闻（待完成）和安全通知（已完成，由服务器上 "repo" 这个 docker 实例提供支持）
3. 不需要放在网站上的页面会归并到 *_temp* 文件夹中
4. `<a href="#">...</a>` 会导致页面刷新，显示效果为跳转到页面顶部，现在以 `<a href="javascript:;">...</a>` 来代替,可以显示链接效果，但是不会跳转, 并且设置样式为充满整个块级元素
5. 响应式布局，兼容大多数浏览设备分辨率，如果发现排版错误请通知我
6. All files are put in the src folder, and the html folder inside have no use for website, just ignore it.

## 自动更新实现流程

"repo" 这个服务器上的 docker 实例在启动时会自动运行脚本，每小时触发更新行为。

具体脚本请见 GitHub debiancn/custodian 项目。

每小时会自动从 GitHub 项目中 `git pull` 得到 master 分支代码，并运行 `make update`
进行 XSLT 自动生成 `index.html` 文件，作为首页。

未来的首页开发应当直接编辑 `index.xsl` 文件，按照 XHTML 标准书写页面即可。
