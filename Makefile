docs: .FORCE
	jb build nbs
	cp -r nbs/_build/html/* docs
	git add -A; git commit -m'generate docs'; git push

.FORCE:
