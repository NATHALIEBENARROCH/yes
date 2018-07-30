all: copy build

copy:
	cp -r ./en/themes ./fr/
	cp -r ./en/static ./fr/
	cp -r ./en/archetypes ./fr/
	cp -r ./en/layouts ./fr/

build:
	/usr/local/bin/hugo -s ./en/ -d public
	/usr/local/bin/hugo -s ./fr/ -d public