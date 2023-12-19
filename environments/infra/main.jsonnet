local apps = import 'apps.libsonnet';
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
    [cluster.name]: env.new(cluster.name, cluster.server, cluster.port) + env.withData(apps)
    for cluster in $.clusters
  },
}
