# Motivation

[tanka](https://tanka.dev/) solves the problem of overwhelming amount of yaml files you
sometimes need to configure your cluster. Tools like [helm](https://helm.sh/) doesn't help
the situation because debugging helm charts is even worse than managing simple yaml files.

tanka hits the perfect sweet spot between functionality and simplicy. It uses [jsonnet](https://jsonnet.org/)
as the configuration language, which is basically json with superpowers. But wait...? Json and simple?

Yeah, I know, hearing json probably doesn't really sparkles joy, but trust me, jsonnet makes it awesome again.

## Get to know the tools

First, [install tanka](https://tanka.dev/install#tanka), for example like this:

```bash
# this will install the "tk" binary
paru -S tanka
```

tanka is the foundation of our configuration. It translates our jsonnet configurations to
yaml manifests. There a several libraries out there that we can use.

You also need [jsonnet-bundler](https://tanka.dev/install#jsonnet-bundler):

```bash
# this will install the "jb" binary
paru -S jsonnet-bundler-bin
```

It's a package manager for jsonnet. tanka uses it to initiate new projects.

Optionally, you can install [my fork](https://github.com/dadav/jsonnet-bundler-ng) instead:

```bash
# this will install the "jb-ng" binary
paru -S jsonnet-bundler-ng-bin
```

This fork has registry support, which makes it easy to find new libraries.

### Useful commands

Here are some commands to help you get started:

```bash
# Create a tanka project
tk init

# Print yaml manifests to stdout
# Be aware: If you want to pipe this to kubectl,
# you have to use the --dangerous-allow-redirect flag
tk show environments/default

# Run diff (cluster vs. declaration)
tk diff environments/default

# Apply configs to cluster
tk apply environments/default

# Add helm charts
tk tool charts init
tk tool charts add-repo $reponame $url
tk tool charts add $reponame/$chart@$version
```

As always, be sure to also read the manual.

## Autocompletion

You could just run `tk complete`, which will just append the required things to your files or
do it manually:

```bash
# bash
complete -C /usr/bin/tk tk

# zsh
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/tk tk
```

## IDE

If you use neovim, I recommend to use [lazyvim](https://lazyvim.org/) with [this config](https://github.com/dadav/dotfiles/blob/master/.config/nvim/lua/plugins/languages/jsonnet.lua).
