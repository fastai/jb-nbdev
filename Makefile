save: docs
	git add -A; git commit -m'generate docs'; git push

docs: meta
	jb build nbs
	cp -r nbs/_build/html/* docs

meta: .FORCE
	python nbs/metadata.py

.FORCE:
