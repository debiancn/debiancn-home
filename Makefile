FORUMS_NEWS_RSS := https://forums.debiancn.org/c/5-category.rss
DEBIAN_NEWS_RSS := https://www.debian.org/News/news
SECURITY_ADVISORY := https://www.debian.org/security/dsa

STATIC_ROOT ?= .
WGET := wget --header='Accept-Language: zh-CN,zh;q=0.9,en;q=0.8'
WGET4 := $(WGET) -4
XSLTPROC := xsltproc --stringparam static-root $(STATIC_ROOT)


all: index.html repo.html privacy-terms.html

.PHONY: all


index.html: templates/index.xsl templates/framework.xsl index.xml rss/news.xml rss/dsa.xml rss/news-forums.xml
	$(XSLTPROC) -o $@ $< index.xml

repo.html: templates/framework.xsl repo.xml
	$(XSLTPROC) -o $@ $< repo.xml

privacy-terms.html: templates/framework.xsl privacy-terms.xml
	$(XSLTPROC) -o $@ $< privacy-terms.xml

repo-header.html repo-footer.html: repo.html
	awk 'BEGIN {RS="split-here"; ORS=""} {print > sprintf("repo-%02d", NR)}' $<
	mv repo-01 repo-header.html
	mv repo-02 repo-footer.html


define check_outdated
.PHONY: $(shell [ `[ -f $(1) ] && find $(1) -cmin -60 -print` ] || echo $(1))
endef

rss/news.xml:
	$(WGET4) -O $@ $(DEBIAN_NEWS_RSS)

$(call check_outdated,rss/news.xml)

rss/dsa.xml:
	$(WGET4) -O $@ $(SECURITY_ADVISORY)

$(call check_outdated,rss/dsa.xml)

rss/news-forums.xml:
	$(WGET) -O $@ $(FORUMS_NEWS_RSS)
	IFS='\
'; for i in `sed -rn 's|.*<pubDate>(.*)</pubDate>|\1| p' $@`; do \
		sed -i "s|$$i|`date --date="$$i" "+%Y-%m-%d"`|" $@; \
	done

$(call check_outdated,rss/news-forums.xml)


clean:
	rm -f *.html rss/*.xml

.PHONY: update clean
