
# unite-pypi-classifiers

source for unite.vim is classifiers requisite in setup.py


# Installation

## Neobundle (recommend)

```vim
NeoBundle 'hachibeeDI/unite-pypi-classifiers'
```

or

```vim
NeoBundleLazy 'hachibeeDI/unite-pypi-classifiers', {
\ 'autoload' : {
\   'unite_sources' : 'pypiclassifiers'},
\ }
```

## Usage

```vim
:Unite pypiclassifiers
" default action is `insert`
```
