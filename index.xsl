<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:purlrss="http://purl.org/rss/1.0/"
                xml:lang="zh"
                exclude-result-prefixes="purlrss"
>
  <xsl:output method="html" indent="yes" encoding="utf-8" />
  <xsl:template match="/">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-CN" lang="zh-CN">
      <head>
        <meta charset="UTF-8" />
        <title>Debian中文社区 - 首页</title>
        <link rel="shortcut icon" href="./images/favicon.ico" />
        <meta http-equiv="X-UA-Compatible" content="chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />

        <link href="https://cdn.bootcss.com/normalize/8.0.0/normalize.css" rel="stylesheet" crossorigin="anonymous" />
        <link href="./css/base.css" rel="stylesheet" />
        <link href="./css/index.css" rel="stylesheet" />
      </head>
      <body>
        <header>
          <div class="logo-box hidden-sm-down">
            <img alt="" src="./images/logo.png" />
          </div>
          <nav class="navbar">
            <div class="navbar-header hidden-md-up">
              <div class="navbar-header-logo-box">
                <img src="images/logo_small.png" alt="Debian中文社区" />
              </div>
              <div class="navbar-header-title">Debian中文社区</div>
              <div class="navbar-header-button">
                <div class="menu-icon"></div>
              </div>
            </div>

            <div class="collapse navbar-collapse">
              <ul class="nav navbar-nav navbar-tabs">
                <li>
                  <a href="#index">首页</a>
                </li>
                <li>
                  <a href="//forums.debiancn.org/">论坛</a>
                </li>
                <li>
                  <a href="//irc.debiancn.org/">聊天室</a>
                </li>
                <li>
                  <a href="//repo.debiancn.org/">社区仓库</a>
                </li>
              </ul>
              <ul class="nav navbar-nav navbar-right navbar-tabs">
                <li>
                  <a href="#contact">联系我们</a>
                </li>
                <li>
                  <a href="#donate">捐助我们</a>
                </li>
              </ul>
            </div>
          </nav>
        </header>

        <main>
          <section class="tab-content tab-active" id="index">
            <div class="col-3">
              <h3>欢迎来到 Debian 中文社区</h3>
              <div class="row">
                <p>Debian 是一个自由的操作系统（OS），供您安装在计算机上使用。</p>
                <p>Debian 系统目前采用 Linux 内核或者 FreeBSD 内核。 Linux 是一个最初由 Linus Torvalds 创建，目前由全球成千上万的程序师共同维护的软件。 FreeBSD
                  是一个包括内核和其它软件的操作系统。
                </p>
                <p>Debian 不只是提供一个纯粹的操作系统：它还附带了超过 51000 个软件包，这些预先编译好的软件被包裹成一种良好的格式以便于在您的机器上进行安装。</p>
                <p>Debian 中文社区是一个专门为 Debian 中文用户而创建的社区。希望为中文用户的学习交流提供一席之地。也希望能有更多人爱上这个自由伟大的操作系统。</p>
              </div>
            </div>

            <div class="detailsOfDebian flex-container">
              <div class="mainContent flex-container">
                <div class="col-2">
                  <h3>
                    新闻
                    <span class="moreMsg">
                      <a href="https://www.debian.org/News/">浏览全部新闻</a>&#8195;<a
                      href="//forums.debiancn.org/c/5-category.rss">社区RSS
                    </a>
                    </span>
                  </h3>
                  <div class="row">
                    <ul class="newsContainer">
                      <xsl:for-each select="document('news.xml')/rdf:RDF/purlrss:item[not(position() > 3)]">
                        <li>
                          <div class="newsDate">
                            <xsl:value-of select="./dc:date" />
                          </div>
                          <div class="newsTitle">
                            <xsl:value-of select="./purlrss:title" />
                          </div>
                          <div class="newsLink">
                            <a>
                              <xsl:attribute name="href">
                                <xsl:value-of select="./purlrss:link" />
                              </xsl:attribute>
                              查看更多
                            </a>
                          </div>
                        </li>
                      </xsl:for-each>
                      <xsl:for-each
                        select="document('news-forums.xml')/rss/channel/item[not(position() > 3)]">
                        <li class="cnNewsItem">
                          <div class="newsDate">
                            <xsl:value-of select="./pubDate" />
                          </div>
                          <div class="newsTitle">
                            <xsl:value-of select="./title" />
                          </div>
                          <div class="newsLink">
                            <a>
                              <xsl:attribute name="href">
                                <xsl:value-of select="./link" />
                              </xsl:attribute>
                              社区新闻
                            </a>
                          </div>
                        </li>
                      </xsl:for-each>
                    </ul>
                  </div>
                </div>

                <div class="guideAndNewsContainer flex-container">
                  <div class="col-1">
                    <h3>入门</h3>
                    <div class="row">
                      <p>
                        如果您想学习如何使用 Debian，那么最好的方式无疑是<a href="https://www.debian.org/distrib/">下载 Debian 镜像</a>并亲自安装使用它。期间遇到的一切问题，可以参考<a
                        href="https://www.debian.org/releases/stable/amd64/index.html.zh-cn">安装说明书</a>，或是在
                        <a href="//forums.debiancn.org">Debian 中文论坛</a>求助或者讨论。
                      </p>
                      <p>
                        同时也欢迎参与 Debian 中文社区的建设工作，如果您对社区建设有什么意见或建议，也欢迎通过社区的<a href="#contact">联系页</a>告诉我们。
                      </p>
                    </div>
                  </div>
                  <div class="col-1">
                    <h3>安全更新
                      <span class="moreMsg">
                        <a href="https://www.debian.org/security/">浏览全部安全更新</a>
                      </span>
                    </h3>
                    <div class="row">
                      <ul class="updateContainer">
                        <xsl:for-each select="document('dsa.xml')/rdf:RDF/purlrss:item[not(position() > 7)]">
                          <li>
                            <div class="updateDate">
                              <xsl:value-of select="./dc:date" />
                            </div>
                            <div class="updateTitle">
                              <a>
                                <xsl:attribute name="href">
                                  <xsl:value-of select="./purlrss:link" />
                                </xsl:attribute>
                                <xsl:value-of select="./purlrss:title" />
                              </a>
                            </div>
                          </li>
                        </xsl:for-each>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>

              <div class="solider flex-container">
                <div class="col-1">
                  <h3>相关链接</h3>
                  <div class="row">
                    <ul class="linkLists">
                      <li>
                        <a href="https://www.debian.org/releases/stable/amd64/index.html.zh-cn">Debian 安装指南</a>
                      </li>
                      <li>
                        <a href="https://www.debian.org/doc/manuals/debian-reference/">Debian 参考手册</a>
                      </li>
                      <li>
                        <a href="https://www.debian.org/distrib/">官方下载页面</a>
                      </li>
                      <li>
                        <a href="https://lists.debian.org/debian-chinese-gb/">中文邮件列表</a>
                      </li>
                      <li>
                        <a href="//irc.debiancn.org/log/debian-cn/today">在线聊天室</a>
                      </li>
                      <li>
                        <a href="https://chinese.alioth.debian.org/cn/">开发参与指南</a>
                      </li>
                      <!-- <li><a href="javascript:">待办事项</a></li>  -->
                      <!-- <li><a href="javascript:">社区礼仪</a></li>  -->
                    </ul>
                  </div>
                </div>

                <div class="col-1">
                  <h3>友情链接</h3>
                  <div class="row">
                    <ul class="linkLists">
                      <li>
                        <a href="https://sb.sb">烧饼博客</a>
                      </li>
                      <li>
                        <a href="https://parrotsec-china.org">ParrotSec 中文社区</a>
                      </li>
                    </ul>
                  </div>
                </div>

                <div class="col-1">
                  <h3>赞助商</h3>
                  <div class="row" style="width:260px; height:180px; margin: 0 auto;">
                    <!--<a href="https://www.ucloud.cn/"><img alt="ucloud" src="./images/ad.jpg"/></a>-->
                    <a
                      href="http://www.ucloud.cn/site/active/gift.html?utm_source=debianchina&amp;utm_medium=content_pic_pc&amp;utm_campaign=multicloud&amp;utm_content=gift&amp;ytag=debianchina">
                      <img alt="ucloud" src="images/sponsor.png" />
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </section>

          <section class="tab-content" id="contact">
            <div class="col-1">
              <h3>和我们取得联系</h3>
              <div class="row">
                <p>如果对 Debian 中文社区有什么意见和建议，或者想要与我们进行合作。您可以通过以下方式和我们取得联系：</p>
                <ol>
                  <li>
                    进入<a href="//irc.debiancn.org/">聊天室</a>即时反馈您的问题，一般都会有人解答。
                  </li>
                  <li>
                    对社区的任何看法和建议都可以在 <a href="//forums.debiancn.org">Debian 中文论坛</a>的<a
                    href="//forums.debiancn.org/c/21-category">社区建设</a>版块畅所欲言。
                  </li>
                  <li>
                    您也可以发邮件到
                    <a href="mailto:service@debiancn.com">service@debiancn.com</a>
                    告诉我们您的看法。我们会尽快回复您。
                  </li>
                </ol>
              </div>
            </div>
          </section>

          <section class="tab-content" id="donate">
            <div class="col-1">
              <h3>捐助我们</h3>
              <div class="row">
                <p>Debian 中文社区是一个非营利公益性站点，给所有 Debian 的中文用户提供一个网上交流学习的场所。</p>
                <p>如果您想捐助我们的网站，可以通过扫描以下二维码使用支付宝给我们捐款。</p>
                <p>受捐所得将全部用于社区建设。</p>
                <p>在此感谢所有捐助、帮助过 Debian 中文社区的人！</p>
                <p>
                  <img alt="支付宝二维码" src="./images/donateUs.jpg" />
                </p>
              </div>
            </div>
          </section>
        </main>

        <footer>
          <p>© 2016-2018 - Debian 中文社区</p>
          <p>Debian 是 Software in the Public Interest, Inc. 的注册商标。本站与 Debian 组织无任何关系。</p>
          <p>服务器由
            <img alt="" src="./images/u.png" />
            赞助
          </p>
          <p>源代码可在 <a href="https://github.com/debiancn/debiancn-home">GitHub</a> 找到。
          </p>
        </footer>

        <script
          src="https://code.jquery.com/jquery-3.3.1.min.js"
          integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
          crossorigin="anonymous"></script>
        <script src="./js/base.js"></script>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
