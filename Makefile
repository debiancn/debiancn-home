FORUMS_NEWS_RSS := https://forums.debiancn.org/c/5-category.rss
DEBIAN_NEWS_RSS := https://www.debian.org/News/news
SECURITY_ADVISORY := https://www.debian.org/security/dsa

WGET := wget --header='Accept-Language: zh-CN,zh;q=0.9,en;q=0.8'

update: index.html

index.html: index.xsl news.xml dsa.xml news-forums.xml
	xsltproc -o $@ ./index.xsl ./dsa.xml

news.xml:
	if ! [ `[ -f $@ ] && find $@ -cmin -60 -print` ]; then \
		$(WGET) -4 -O $@ -t 0 $(DEBIAN_NEWS_RSS) ; \
	fi

dsa.xml:
	if ! [ `[ -f $@ ] && find $@ -cmin -60 -print` ]; then \
		$(WGET) -4 -O $@ -t 0 $(SECURITY_ADVISORY) ; \
	fi

news-forums.xml:
	if ! [ `[ -f $@ ] && find $@ -cmin -60 -print` ]; then \
		$(WGET) -O $@ -t 100 $(FORUMS_NEWS_RSS) ; \
		IFS='\
'; for i in `sed -rn 's|.*<pubDate>(.*)</pubDate>|\1| p' $@`; do \
			sed -i "s|$$i|`date --date="$$i" "+%Y-%m-%d"`|" $@; \
		done ; \
	fi

clean:
	rm -f index.html news.xml dsa.xml news-forums.xml

.PHONY: update news.xml dsa.xml news-forums.xml clean
