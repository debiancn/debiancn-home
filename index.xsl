<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:purlrss="http://purl.org/rss/1.0/"
  xml:lang="zh"
  exclude-result-prefixes="purlrss"
>
  <xsl:output method="html" indent="yes" encoding="UTF-8"/>
  <xsl:template match="/">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh-CN">
      <head>
        <meta charset="UTF-8"/>
        <title>Debian中文社区 - 首页</title>
        <link rel="shortcut icon" href="./images/favicon.ico"/>
        <meta http-equiv="X-UA-Compatible" content="chrome=1"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>

        <link href="./css/ls_base.css" rel="stylesheet" />
        <link href="./css/ls_index.css" rel="stylesheet"/>
      </head>
      <body>
        <div class="ls_container">
          <div class="IEWarning">
          </div>
          <header>
            <div class="logoContainer mobi_hide">
              <img alt="" src="./images/logo.png"/>
            </div>
            <nav class="navigationContainer">
              <div class="navMobi mobi_show">
                <div class="navMobiLeft">
                  <img id="logo_small" src="images/logo_small.png" alt="Debian中文社区" />
                </div>
                <div class="navMobiTitle">Debian中文社区</div>
                <div class="navMobiRight"><div class="menu_mobi"></div></div>
              </div>
              <div class="menuListDiv">
                <ul class="menuList clearfix mobi_hide">
                  <li class="menuListSelected"><a href="javascript:;" class="indexClick">首页</a></li>
                  <li><a href="https://forums.debiancn.org/">论坛</a></li>
                  <li><a href="http://wiki.debiancn.org/">WIKI</a></li>
                  <li><a href="https://irc.debiancn.org/">聊天室</a></li>
                  <li><a href="https://repo.debiancn.org/">社区仓库</a></li>
                  <li><a href="javascript:;" class="contactClick">联系我们</a></li>
                  <li class="menuListLast"><a href="javascript:;" class="donateClick" >捐助我们</a></li>
                </ul>
              </div>
            </nav>
          </header>

          <div class="mainContainer layoutIndex">
            <div class="welcomeContainer">
              <div class="col-3">
                <h3 class="paragraphTitle">欢迎来到 Debian 中文社区</h3>
                <div class="paragraphContent">
                  <p>Debian 是一个自由的操作系统（OS），供您安装在计算机上使用。</p>
                  <p>Debian 系统目前采用 Linux 内核或者 FreeBSD 内核。 Linux 是一个最初由 Linus Torvalds 创建，目前由全球成千上万的程序师共同维护的软件。 FreeBSD 是一个包括内核和其它软件的操作系统。</p>
                  <p>Debian 不只是提供一个纯粹的操作系统：它还附带了超过 43000 个软件包，这些预先编译好的软件被包裹成一种良好的格式以便于在您的机器上进行安装。</p>
                  <p>Debian中文社区是一个专门为Debian中文用户而创建的社区。希望为中文用户的学习交流提供一席之地。也希望能有更多人爱上这个自由伟大的操作系统。</p>
                </div>
              </div>
            </div>
            <div class="detailsOfDebian">
              <div class="mainContent">
                <div class="col-2">
                  <h3 class="paragraphTitle">新闻 <span class="moreMsg"><a href="https://www.debian.org/News/">浏览全部新闻</a></span></h3>
                  <div class="paragraphContent">
                    <ul class="newsContainer">
                      <li>
                        <div class="newsDate">2017年4月25日</div>
                        <div class="newsTitle">Debian 将关闭公共 FTP 服务</div>
                        <div class="newsLink"><a href="https://www.debian.org/News/2017/20170425">查看更多</a></div>
                      </li>
                      <li>
                        <div class="newsDate">2017年4月17日</div>
                        <div class="newsTitle">对 Dmitry Bogatov 被捕一事的陈述</div>
                        <div class="newsLink"><a href="https://www.debian.org/News/2017/20170417">查看更多</a></div>
                      </li>
                      <li>
                        <div class="newsDate">2017年1月14日</div>
                        <div class="newsTitle">Debian 8 更新：8.7版本发布</div>
                        <div class="newsLink"><a href="https://www.debian.org/News/2017/20170114">查看更多</a></div>
                      </li>
                      <xsl:for-each select="document('news-forums.debiancn.org.xml')/rss/channel/item[not(position() > 3)]">
                        <li>
                          <div class="newsDate">
                            <xsl:value-of select="./pubDate"/>
                          </div>
                          <div class="newsTitle">
                            <xsl:value-of select="./title"/>
                          </div>
                          <div class="newsLink">
                            <a>
                              <xsl:attribute name="href">
                                <xsl:value-of select="./link"/>
                              </xsl:attribute>
                              社区新闻
                            </a>
                          </div>
                        </li>
                      </xsl:for-each>
                    </ul>
                  </div>
                </div>
                <div class="guideAndNewsContainer">
                  <div class="col-1">
                    <h3 class="paragraphTitle">入门</h3>
                    <div class="paragraphContent">
                      <p>如果你是一名新人，对Debian产生了兴趣，想要进一步了解关于Debian的一切，那么 <a href="http://wiki.debiancn.org/">Debian中文Wiki</a> 是你开始Debian之旅很好的指引。</p>
                      <p>如果你想学习如何使用Debian，那么最好的方式无疑是 <a href="https://www.debian.org/distrib/">下载Debian镜像</a> 并亲自安装使用它。期间遇到的一切问题都可以在 <a href="javascript:;">Debian中文论坛</a> 求助或者讨论。</p>
                      <p>同时也欢迎参与Debian中文社区的建设工作,可以在 <a href="javascript:;">这儿</a> 找到参与社区工作的相关指引。如果你对社区建设有什么意见或建议,也欢迎通过社区的 <a href="javascript:;">联系页</a> 告诉我们。</p>
                    </div>
                  </div>
                  <div class="col-1">
                    <h3 class="paragraphTitle">安全更新 <span class="moreMsg"><a href="https://www.debian.org/security/index.en.html">浏览全部安全更新</a></span></h3>
                    <div class="paragraphContent">
                      <ul class="updateContainer">
                          <xsl:for-each select="/rdf:RDF/purlrss:item">
                          <li>
                            <div class="updateDate">
                              <xsl:value-of select="./dc:date"/>
                            </div>
                            <div class="updateTitle">
                              <a>
                                <xsl:attribute name="href">
                                  <xsl:value-of select="./purlrss:link"/>
                                </xsl:attribute>
                                <xsl:value-of select="./purlrss:title"/>
                              </a>
                            </div>
                          </li>
                        </xsl:for-each>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
              <div class="solider">
                <div class="col-1">
                  <h3 class="paragraphTitle">相关链接</h3>
                  <div class="paragraphContent">
                    <ul class="linkLists">
                      <li><a href="https://www.debian.org/releases/stable/amd64/index.html.zh-cn">Debian安装指南</a></li>
                      <li><a href="https://www.debian.org/distrib/">官方下载页面</a></li>
                      <li><a href="https://lists.debian.org/debian-chinese-gb/">中文邮件列表</a></li>
                      <li><a href="https://irc.debiancn.org/log/debian-cn/today">在线聊天室</a></li>
                      <li><a href="https://chinese.alioth.debian.org/cn/">开发参与指南</a></li>
                      <!-- <li><a href="javascript:;">待办事项</a></li>  -->
                      <!-- <li><a href="javascript:;">社区礼仪</a></li>  -->
                    </ul>
                  </div>
                </div>
                <div class="col-1">
                  <h3 class="paragraphTitle">赞助商</h3>
                  <div class="paragraphContent" style="width:260px; height:180px; margin: 0 auto;">
                    <!--<a href="https://www.ucloud.cn/"><img alt="ucloud" src="./images/ad.jpg"/></a>-->
                    <a href="http://www.ucloud.cn/site/active/gift.html?utm_source=debianchina&amp;utm_medium=content_pic_pc&amp;utm_campaign=multicloud&amp;utm_content=gift&amp;ytag=debianchina"><img alt="ucloud" src="images/sponsor.png"/></a>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="mainContainer layoutContact">
            <div class="col-1">
              <h3 class="paragraphTitle">和我们取得联系</h3>
              <div class="paragraphContent">
                <p>如果对Debian中文社区有什么意见和建议，或者想要与我们进行合作。你可以通过以下方式和我们取得联系：</p>
                <ol class="contactList">
                  <li>对社区的任何看法和建议都可以在Debian中文论坛的 社区建设 版块畅所欲言。</li>
                  <li>你也可以发邮件到 service@debiancn.com 告诉我们你的看法。我们会尽快回复你。</li>
                </ol>
              </div>
            </div>
          </div>

          <div class="mainContainer layoutDonate">
            <div class="col-1">
              <h3 class="paragraphTitle">捐助我们</h3>
              <div class="paragraphContent">
                <p>Debian中文社区是一个非营利公益性站点，给所有 Debian 的中文用户提供一个网上交流学习的场所。</p>
                <p>如果你想捐助我们的网站，可以通过扫描以下二维码使用支付宝给我们捐款。</p>
                <p>受捐所得将全部用于社区建设。</p>
                <p>在此谢谢所有捐助、帮助过 Debian 中文社区的人！</p>
                <div>
                  <img alt="" src="./images/donateUs.jpg"/>
                </div>
              </div>
            </div>
          </div>

          <footer>
            <p>© 2016-2017 - Debian 中文社区</p>
            <p>Debian 是 Software in the Public Interest, Inc. 的注册商标。</p>
            <p>服务器由 <img alt="" src="./images/u.png"/> 赞助</p>
          </footer>
        </div>
      </body>

      <script src="./js/libs/jquery-1.12.4.min.js"></script>
      <script src="./js/ls_script.js"></script>
    </html>
  </xsl:template>

</xsl:stylesheet>
