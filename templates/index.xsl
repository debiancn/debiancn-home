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
  </xsl:template>

  <xsl:template match="list-news-forums">
    <xsl:for-each select="document('../rss/news-forums.xml')/rss/channel/item[not(position() > 3)]">
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
  </xsl:template>

  <xsl:template match="list-dsa">
    <xsl:for-each select="document('../rss/dsa.xml')/rdf:RDF/purlrss:item[not(position() > 7)]">
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
  </xsl:template>
</xsl:stylesheet>
