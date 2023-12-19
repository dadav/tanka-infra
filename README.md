# 🐝 How-To: infrastructure with tanka

I'm using this repository to learn how to use tanka to manage my infrastructure.
I want to create examples for the following scenarios (basic to advanced):

- One cluster, one stage, no CI
- One cluster, two stages, no CI
- Two cluster, two stages, no CI
- Two cluster, two stages, CI

We want to be able to easily add new apps, stages and clusters.
The basic set of apps we want on all clusters are:

- Kubernetes Dashboard: To get an overview of our clusters
- ArgoCD: To deploy our stuff automatically from our git repo
- Kyverno: To enforce some policies
- Starboard: To scan and audit our cluster for security issues.

For every app we'll need to check the installation method and abstract these
into some handy jsonnet library.

Every scenario will have a branch.
Every branch is based on the previous scenarios branch.

You should [start here](https://github.com/dadav/tanka-infra/blob/start_here/start.md).
