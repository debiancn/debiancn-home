FORUMS_NEWS_RSS := https://forums.debiancn.org/c/5-category.rss

update: index.html

index.html: index.xsl dsa.xml news-forums.debiancn.org.xml
	xsltproc -o index.html ./index.xsl ./dsa.xml

dsa.xml:
	wget -4 -O dsa.xml -t 0 https://www.debian.org/security/dsa

news-forums.debiancn.org.xml:
	wget -t 100 $(FORUMS_NEWS_RSS) -O news-forums.debiancn.org.xml

.PHONY: dsa.xml update news-forums.debiancn.org.xml
