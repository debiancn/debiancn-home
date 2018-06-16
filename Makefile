FORUMS_NEWS_RSS := https://forums.debiancn.org/c/5-category.rss
SECURITY_ADVISORY := https://www.debian.org/security/dsa

update: index.html

index.html: index.xsl dsa.xml news-forums.debiancn.org.xml
	xsltproc -o $@ ./index.xsl ./dsa.xml

dsa.xml:
	if [ `find $@ -cmin +60 -print` ]; then \
		wget -4 -O $@ -t 0 $(SECURITY_ADVISORY) ; \
	fi

news-forums.debiancn.org.xml:
	if [ `find $@ -cmin +60 -print` ]; then \
		wget -O $@ -t 100 $(FORUMS_NEWS_RSS) ; \
	fi

.PHONY: update dsa.xml news-forums.debiancn.org.xml
