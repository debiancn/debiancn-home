<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:purlrss="http://purl.org/rss/1.0/"
                xml:lang="zh"
                exclude-result-prefixes="purlrss"
>
  <xsl:include href="framework.xsl" />

  <xsl:template match="list-news">
    <xsl:for-each select="document('../rss/news.xml')/rdf:RDF/purlrss:item[not(position() > 3)]">
      <li class="news-item">
        <time class="news-date" datetime="{./dc:date}">
          <xsl:value-of select="./dc:date" />
        </time>
        <a class="news-title" href="{./purlrss:link}">
          <xsl:value-of select="./purlrss:title" />
        </a>
        <span class="news-tag">官方</span>
      </li>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="list-news-forums">
    <xsl:for-each select="document('../rss/news-forums.xml')/rss/channel/item[not(position() > 3)]">
      <li class="news-item">
        <time class="news-date" datetime="{./pubDate}">
          <xsl:value-of select="./pubDate" />
        </time>
        <a class="news-title" href="{./link}">
          <xsl:value-of select="./title" />
        </a>
        <span class="news-tag">社区</span>
      </li>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="list-dsa">
    <xsl:for-each select="document('../rss/dsa.xml')/rdf:RDF/purlrss:item[not(position() > 7)]">
      <li class="update-item">
        <time class="update-date" datetime="{./dc:date}">
          <xsl:value-of select="./dc:date" />
        </time>
        <a class="update-title" href="{./purlrss:link}">
          <xsl:value-of select="./purlrss:title" />
        </a>
      </li>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
