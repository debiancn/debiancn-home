update: index.html

index.html: index.xsl dsa.xml
	xsltproc -o index.html ./index.xsl ./dsa.xml

dsa.xml:
	wget -4 -O dsa.xml -t 0 https://www.debian.org/security/dsa

.PHONY: dsa.xml update
