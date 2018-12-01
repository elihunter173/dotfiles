# Neovim Config

```no-highlight
layer
├── layer-name : A directory named and focued on a single aspect of the editor.
│   ├── after : A directory containing all globs that should be added to the Neovim runtime path.
│   │   ├── ...
│   │   ...
│   ├── config.vim : A file containing all the config run-commands for this specific layer.
│   └── package.vim : A file containing all the plugins by vim-plug.
...
```

*N.B. All parts of a layer are optional.*
