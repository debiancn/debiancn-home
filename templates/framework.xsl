<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes=""
>
  <xsl:output method="html" indent="yes" encoding="UTF-8" />

  <xsl:param name="domain-name" select="'debiancn.org'" />
  <xsl:param name="static-root" select="concat('static.', $domain-name)" />

  <xsl:template match="*">
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@*|node()" />
    </xsl:element>
  </xsl:template>

  <xsl:template match="@*|text()|comment()">
    <xsl:copy />
  </xsl:template>

  <xsl:template match="@href|@src">
    <xsl:choose>
      <xsl:when test="starts-with(., './')">
        <xsl:attribute name="{name()}">
          <xsl:value-of select="concat($static-root, substring(., 2))" />
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="/webpage/navbar/*/@align" />

  <xsl:template match="/webpage">
    <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;
&lt;html lang="zh-CN"&gt;
</xsl:text>
    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <meta name="color-scheme" content="light dark" />
      <meta name="theme-color" content="#ffffff" media="(prefers-color-scheme: light)" />
      <meta name="theme-color" content="#0f1115" media="(prefers-color-scheme: dark)" />
      <meta name="description" content="{description}" />
      <meta property="og:title" content="{title}" />
      <meta property="og:description" content="{description}" />
      <meta property="og:type" content="website" />
      <meta property="og:url" content="{og-url}" />
      <meta property="og:image" content="https://www.debiancn.org/images/debian-logo.svg" />
      <meta name="twitter:card" content="summary" />
      <title><xsl:value-of select="title" /></title>

      <link rel="icon" href="{$static-root}/images/favicon.ico" />
      <link rel="icon" type="image/svg+xml" href="{$static-root}/images/debian-logo.svg" />
      <link rel="apple-touch-icon" href="{$static-root}/images/debian-logo.svg" />
      <link rel="canonical" href="{og-url}" />

      <xsl:text disable-output-escaping="yes">&lt;script&gt;(function(){var t=null;try{t=localStorage.getItem("debiancn-theme")}catch(e){}if(t!=="light"&amp;&amp;t!=="dark"){t=window.matchMedia&amp;&amp;window.matchMedia("(prefers-color-scheme: dark)").matches?"dark":"light"}document.documentElement.setAttribute("data-theme",t)})();&lt;/script&gt;</xsl:text>

      <link rel="stylesheet" href="{$static-root}/css/base.css" />
      <xsl:apply-templates select="link" />
    </head>

    <body>
      <a class="skip-link" href="#main">跳到主要内容</a>

      <header class="site-header">
        <div class="header-inner">
          <a class="brand" href="/">
            <img class="brand-logo" src="{$static-root}/images/debian-logo.svg" alt="Debian 中文社区" width="34" height="42" decoding="async" />
            <span class="brand-name"><xsl:value-of select="title" /></span>
          </a>

          <div class="header-actions">
            <xsl:apply-templates select="header/*" />

            <button type="button" class="icon-button theme-toggle" aria-label="切换深色模式" aria-pressed="false">
              <svg class="icon-sun" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <circle cx="12" cy="12" r="4" />
                <path d="M12 2v2M12 20v2M4.93 4.93l1.41 1.41M17.66 17.66l1.41 1.41M2 12h2M20 12h2M6.34 17.66l-1.41 1.41M19.07 4.93l-1.41 1.41" />
              </svg>
              <svg class="icon-moon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z" />
              </svg>
            </button>

            <button type="button" class="icon-button menu-toggle" aria-label="打开菜单" aria-expanded="false" aria-controls="site-nav">
              <span class="menu-icon" aria-hidden="true"></span>
            </button>
          </div>
        </div>

        <nav class="site-nav" id="site-nav" aria-label="主导航">
          <div class="nav-inner">
            <ul class="nav-list nav-list-main">
              <xsl:apply-templates select="navbar/*[not(@align='right') and local-name()='li']" />
            </ul>
            <xsl:apply-templates select="navbar/*[not(@align='right') and local-name()!='li']" />
            <ul class="nav-list nav-list-side">
              <xsl:apply-templates select="navbar/*[@align='right' and local-name()='li']" />
            </ul>
            <xsl:apply-templates select="navbar/*[@align='right' and local-name()!='li']" />
          </div>
        </nav>
      </header>

      <main id="main">
        <xsl:apply-templates select="body/*" />
      </main>

      <footer class="site-footer">
        <div class="footer-inner">
          <div class="footer-grid">
            <a class="footer-brand" href="/">
              <img src="{$static-root}/images/debian-logo.svg" alt="" width="24" height="30" loading="lazy" decoding="async" />
              <span>Debian 中文社区</span>
            </a>
            <nav class="footer-nav" aria-label="页脚导航">
              <a href="//www.debiancn.org/">首页</a>
              <a href="//forums.debiancn.org/">论坛</a>
              <a href="//irc.debiancn.org/">聊天室</a>
              <a href="//repo.debiancn.org/">软件源</a>
            </nav>
          </div>
          <div class="footer-bottom">
            <p>© 2016-2026 - <a href="//www.debiancn.org">Debian 中文社区</a></p>
            <p>Debian 是 Software in the Public Interest, Inc. 的注册商标。本站与 Debian 组织没有任何关系。</p>
            <p>本网站源代码可以在 <a href="https://github.com/debiancn/debiancn-home">GitHub</a> 找到。 · <a href="//www.debiancn.org/privacy-terms.html">服务条款和隐私政策</a></p>
          </div>
        </div>
      </footer>

      <script src="{$static-root}/js/theme.js" defer="defer" />
      <script src="{$static-root}/js/navbar.js" defer="defer" />
      <xsl:if test="script[@common='tab']">
        <script src="{$static-root}/js/tab.js" defer="defer" />
      </xsl:if>
      <xsl:apply-templates select="script[not(@common)]" />
    </body>
  </xsl:template>
</xsl:stylesheet>
