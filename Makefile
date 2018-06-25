FORUMS_NEWS_RSS := https://forums.debiancn.org/c/5-category.rss
DEBIAN_NEWS_RSS := https://www.debian.org/News/news
SECURITY_ADVISORY := https://www.debian.org/security/dsa

WGET := wget --header='Accept-Language: zh-CN,zh;q=0.9,en;q=0.8'
XSLTPROC := xsltproc --stringparam static-root .

update: index.html repo.html

index.html: templates/index.xsl templates/framework.xsl index.xml rss/news.xml rss/dsa.xml rss/news-forums.xml
	$(XSLTPROC) -o $@ $< index.xml

repo.html: templates/framework.xsl repo.xml
	$(XSLTPROC) -o $@ $< repo.xml

rss/news.xml: $(shell [ `[ -f rss/news.xml ] && find rss/news.xml -cmin -60 -print` ] || echo update-rss)
	$(WGET) -4 -O $@ -t 0 $(DEBIAN_NEWS_RSS)

rss/dsa.xml: $(shell [ `[ -f rss/dsa.xml ] && find rss/dsa.xml -cmin -60 -print` ] || echo update-rss)
	$(WGET) -4 -O $@ -t 0 $(SECURITY_ADVISORY)

rss/news-forums.xml: $(shell [ `[ -f rss/news-forums.xml ] && find rss/news-forums.xml -cmin -60 -print` ] || echo update-rss)
	$(WGET) -O $@ -t 100 $(FORUMS_NEWS_RSS)
	IFS='\
'; for i in `sed -rn 's|.*<pubDate>(.*)</pubDate>|\1| p' $@`; do \
		sed -i "s|$$i|`date --date="$$i" "+%Y-%m-%d"`|" $@; \
	done

update-rss:
	true

clean:
	rm -f *.html rss/*.xml

.PHONY: update clean update-rss
