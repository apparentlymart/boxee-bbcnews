
REPO_ID = uk.me.mart
VERSION = 1.1

all: target/$(REPO_ID).bbcnews-$(VERSION).zip target/$(REPO_ID).bbcparliament-$(VERSION).zip target/$(REPO_ID).bbcworldnews-$(VERSION).zip target/$(REPO_ID).skynews-$(VERSION).zip

target/$(REPO_ID).bbcnews-$(VERSION).zip: descriptor.xml start.py genapp.pl
	perl genapp.pl bbcnews

target/$(REPO_ID).bbcworldnews-$(VERSION).zip: descriptor.xml start.py genapp.pl
	perl genapp.pl bbcworldnews

target/$(REPO_ID).bbcparliament-$(VERSION).zip: descriptor.xml start.py genapp.pl
	perl genapp.pl bbcparliament

target/$(REPO_ID).skynews-$(VERSION).zip: descriptor.xml start.py genapp.pl
	perl genapp.pl skynews

