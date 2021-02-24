docs: git-save
	jb build nbs
	cp -r nbs/_build/html/* docs

git-save:
	git add -A
	git commit -m'generate docs'
	git push
