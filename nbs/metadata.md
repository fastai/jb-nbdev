
# Insert Metadata

Poopulate cell metadata by using cell comments.  

```{code-cell} ipython3
from fastcore.all import *
from nbdev.export2html import (_re_show_doc, _re_hide_input, _re_hide_output, _re_hide, _re_cell_to_remove, _mk_flag_re,
                              _re_cell_to_collapse_closed, _re_cell_to_collapse_output, check_re_multi, check_re)
from nbdev.export import check_re_multi
import glob
import nbformat as nbf
```

```{code-cell} ipython3
print('hello')
```

```{code-cell} ipython3
#export
def nbglob(fname='.', recursive=False, extension='.ipynb', config_key='nbs_path') -> L:
    "Find all files in a directory matching an extension given a `config_key`. Ignores hidden directories and filenames starting with `_`"
    fname = Path(fname)
    if fname.is_dir(): fname = f'{fname.absolute()}/**/*{extension}' if recursive else f'{fname.absolute()}/*{extension}'
    fls = L(glob.glob(str(fname), recursive=recursive)).filter(lambda x: '/.' not in x).map(Path)
    return fls.filter(lambda x: not x.name.startswith('_') and x.name.endswith(extension))
```

```{code-cell} ipython3
def upd_metadata(cell, tag):
    cell_tags = list(set(cell.get('metadata', {}).get('tags', [])))
    if tag not in cell_tags: cell_tags.append(tag)
    cell['metadata']['tags'] = cell_tags
```

```{code-cell} ipython3
#export
def hide(cell):
    "Hide inputs of `cell` that need to be hidden"
    if check_re_multi(cell, [_re_show_doc, *_re_hide_input]): upd_metadata(cell, 'remove-input')
    elif check_re(cell, _re_hide_output): upd_metadata(cell, 'remove-output')
    elif check_re_multi(cell, [_re_hide, _re_cell_to_remove]): upd_metadata(cell, 'remove-cell')
    return cell


_re_cell_to_collapse_input = _mk_flag_re('(collapse_input|collapse-input)', 0, "Cell with #collapse_input")

def collapse_cells(cell):
    "Add a collapse button to inputs or outputs of `cell` in either the open or closed position"
    if check_re(cell, _re_cell_to_collapse_input): upd_metadata(cell,'hide-input')
#     elif check_re(cell, _re_cell_to_collapse_open): upd_metadata(cell,'collapse_show')  THIS doesn't appear to be supported.
    elif check_re(cell, _re_cell_to_collapse_output): upd_metadata(cell,'hide-output')
    return cell
```

```{code-cell} ipython3
if __name__ == '__main__':

    _func = compose(hide, collapse_cells)
    files = nbglob('nbs/')

    for file in files:
        nb = nbf.read(file, nbf.NO_CONVERT)
        for cell in nb.cells: _func(cell)
        nbf.write(nb, file)
```
