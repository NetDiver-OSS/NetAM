
install: docs-install

docs-install:
	pip3 install -r mkdocs-requirements.txt

docs-build:
	mkdocs build

docs-dev:
	mkdocs serve
