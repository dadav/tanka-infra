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
paru -S tanka
```

You also need [jsonnet-bundler](https://tanka.dev/install#jsonnet-bundler). Optionally, you
can install [my fork](https://github.com/dadav/jsonnet-bundler-ng):

```bash
paru -S jsonnet-bundler-ng-bin
```
