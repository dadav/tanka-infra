# First scenario

For this first scenario we'll need _one_ cluster. So we make use of our helper
and create one like this:

```bash
./helpers/c ichiban 9001
```

<details>
<summary>Output</summary>

```bash
INFO[0000] Prep: Network
INFO[0000] Created network 'k3d-ichiban'
INFO[0000] Created image volume k3d-ichiban-images
INFO[0000] Starting new tools node...
INFO[0000] Starting Node 'k3d-ichiban-tools'
INFO[0001] Creating node 'k3d-ichiban-server-0'
INFO[0001] Creating LoadBalancer 'k3d-ichiban-serverlb'
INFO[0001] Using the k3d-tools node to gather environment information
INFO[0001] HostIP: using network gateway 172.18.0.1 address
INFO[0001] Starting cluster 'ichiban'
INFO[0001] Starting servers...
INFO[0001] Starting Node 'k3d-ichiban-server-0'
INFO[0007] All agents already running.
INFO[0007] Starting helpers...
INFO[0007] Starting Node 'k3d-ichiban-serverlb'
INFO[0013] Injecting records for hostAliases (incl. host.k3d.internal) and for 2 network members into CoreDNS configmap...
INFO[0015] Cluster 'ichiban' created successfully!
INFO[0015] You can now use it like this:
kubectl cluster-info
```

</details>

Now we need to know which kubernetes version actually got installed:

```bash
# k is an alias to kubectl
k version
```

<details>
<summary>Output</summary>

```bash
Client Version: v1.29.0
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
Server Version: v1.27.4+k3s1
WARNING: version difference between client (1.29) and server (1.27) exceeds the supported minor version skew of +/-1
```

</details>

With this information we can initiate our tanka configurations:

```bash
# we need --force here because the current dir is not empty
# and the version is 1.27 because we got this from `k version`
tk init --force --k8s=1.27
```

<details>
<summary>Output</summary>

```bash
GET https://github.com/jsonnet-libs/k8s-libsonnet/archive/3e32f80d1493d1579d273d1522af1fae2cc7c97f.tar.gz 200
GET https://github.com/grafana/jsonnet-libs/archive/713fd91d18800dd2d68670506bfc8b073d17612a.tar.gz 200
GET https://github.com/jsonnet-libs/docsonnet/archive/6ac6c69685b8c29c54515448eaca583da2d88150.tar.gz 200
Directory structure set up! Remember to configure the API endpoint:
`tk env set environments/default --server=https://127.0.0.1:6443`
```

</details>

There is already a problem with what just happened. Tanka created an environment called `default` and printed
a wrong ip and port for our first ichiban server.

Just delete that whole directory `environments/default`.

```bash
rm -rf environments/default
```

Now we create our own environment. We have two possibilities here.

- Configure our environment in a `spec.json` file
- Configure our environment in `main.jsonnet` (also called `inline environment`)

We'll go for the second method, because it's more flexible. We can generate the environments by
code and don't have to maintain multiple spec.json files.

```bash
# this will be our entrypoint
tk env set environments/infra --inline --server=https://0.0.0.0:9001
```

This will create the following `main.jsonnet` file:

```jsonnet
{
  apiVersion: 'tanka.dev/v1alpha1',
  kind: 'Environment',
  metadata: {
    name: 'environments/infra',
  },
  spec: {
    apiServer: 'https://0.0.0.0:9001',
    namespace: 'default',
    resourceDefaults: {},
    expectVersions: {},
  },
  data: {},
}
```

Which is a nice piece of code we can put into a function.
Be sure to check out [this docs](https://tanka.dev/config#file-format) to get some
explanations for the options.

Let's create a new file for this.
The right place for this is the `lib` directory. So let's try `lib/env.libsonnet`.

<details>
<summary>Example</summary>

[See here](./lib/env.libsonnet)

</details>

With this library we can create one new environment like this:

```jsonnet
local env = import 'env.libsonnet';

env.new('ichiban', '0.0.0.0', 9001)
```

This works because the function call will return a single object.
If we would now want to create another environment, we could not just
add another line like this, because it would result in something like this:

```jsonnet
{...}
{...}
```

We must return a single object instead...

```jsonnet
[
  {...},
  {...}
]
```

Or even better:

```jsonnet
{
  foo: {...},
  bar: {...}
}
```

It's better because we can now reference them by name, not by index.

Let's adjust the code!

```jsonnet
local env = import 'env.libsonnet';

{
  clusters:: [
    {
      name: 'ichiban',
      server: '0.0.0.0',
      port: 9001,
    },
  ],

  envs: {
    [cluster.name]: env.new(cluster.name, cluster.server, cluster.port)
    for cluster in $.clusters
  },
}
```

Now we have a single array (`clusters`, which is hidden by `::`) which will be
looped over. On every loop the `env.new` function is called.

We haven't talked about how to add new things to the environment yet...

Every environment has a `data` key. This key contains the manifest we want to create.
This is why I added the `env.withData` function. We can make use of it like this:

```jsonnet
{
  envs: {
    [cluster.name]:
      env.new(cluster.name, cluster.server, cluster.port)
      + env.withData(apps)
    for cluster in $.clusters
  },
}
```

This will add the deployments specified in the variable `apps` to every cluster in the array.

Let's create that in `lib/apps.libsonnet`.

<details>
<summary>Example</summary>

[See here](./lib/apps.libsonnet)

</details>

We already know which apps we want to install ([see here](./README.md)), so let's check out how
we can do this.

## Kubernetes dashboard

Instructions can be found [here](https://artifacthub.io/packages/helm/k8s-dashboard/kubernetes-dashboard).
The dashboard is installed via helm. Thankfully tanka supports helm, so let's get started:

```bash
# setup chart
tk tool charts init
tk tool charts add-repo dashboard https://kubernetes.github.io/dashboard/
tk tool charts add dashboard/kubernetes-dashboard@6.0.8

# install required tanka-util package
jb install github.com/grafana/jsonnet-libs/tanka-util
```

Now we can just use the helm chart in the `apps.libsonnet` file:

```libsonnet
local k = import 'github.com/grafana/jsonnet-libs/ksonnet-util/kausal.libsonnet';
local tanka = import 'github.com/grafana/jsonnet-libs/tanka-util/main.libsonnet';
local helm = tanka.helm.new(std.thisFile);

local helm_install(name, namespace, values={}) = {
  ns: k.core.v1.namespace.new(namespace),
  chart: tanka.k8s.patchKubernetesObjects(
    helm.template(name, '../charts/%s' % name, {
      namespace: namespace,
      values: values,
    }),
    {
      metadata+: { namespace: namespace },
    }
  ),
};

{
  dashboard: helm_install('kubernetes-dashboard', 'dashboard'),
}
```

Now you can test it with:

```bash
tk apply environments/infra --name environment/ichiban
```

Now you can run the usual kubectl port-forward command and access the kubernetes dashboard.
Be sure to follow [this guide](https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md) to get a valid token.

## ArgoCD

It's basically the same...

Add the chart-repo, add the chart, add some code, done.

## Kyverno

Same
