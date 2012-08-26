
official: bbcnews-1.0.zip

local: uk.me.mart.bbcnews-1.0.zip

bbcnews-1.0.zip: clean descriptor.xml start.py
	rm -rf bbcnews || echo "didn't remove 'bbcnews' build dir"
	mkdir bbcnews
	cp descriptor.xml bbcnews
	cp start.py bbcnews
	rm bbcnews-1.0.zip
	zip -r bbcnews-1.0.zip bbcnews/

uk.me.mart.bbcnews-1.0.zip: clean descriptor.xml start.py
	rm -rf uk.me.mart.bbcnews || echo "didn't remove 'uk.me.mart.bbcnews' build dir"
	mkdir uk.me.mart.bbcnews
	sed 's/<id>bbcnews/<id>uk.me.mart.bbcnews/' descriptor.xml >uk.me.mart.bbcnews/descriptor.xml
	cp start.py uk.me.mart.bbcnews
	rm uk.me.mart.bbcnews-1.0.zip
	zip -r uk.me.mart.bbcnews-1.0.zip uk.me.mart.bbcnews/
