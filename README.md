# jb-nbdev

> Exploring how nbdev may use JupyterBook

https://fastai.github.io/jb-nbdev/

## Notes

Things I like
- Don't have to move images
- Scrolling TOC on each page
- Built in search w/o ads with lunr.js
- The theme is really nice and modern
- There is very powerful markdown option that gives you almost everything you need. 
- Seems like there is 100% feature parity with things we have in nbdev (i.e. hiding cells, note blocks etc.)


Things I don't like
- Built on sphinx which is a much harder to understand documentation system compared to a static site generator. 


How to make it work
- put .gitignore (to ignore the temporary build assets), _config.yml, toc.yml in your nbs folder
- in the notebooks folder: `jb build .`
- copy the HTML over to the docs: `cp -r _build/html/* ../docs`
- Make sure there is a `.nojekyll` file in the docs folder.
- Enable gh pages in settings per usual 

TODO:

1. Create a script for the build
2. Propagate nbdev comments/flags into metadata recognized by jupyterbook (ex: Show//Hide Cells)
3. Looks like certain things are lost like the auto-linking?  Probably need to do some kind of post-processing
4. ...
