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
  argocd: helm_install('argo-cd', 'argocd'),
  kyverno: helm_install('kyverno', 'kyverno'),
  starboard: helm_install('starboard-operator', 'starboard'),
}
