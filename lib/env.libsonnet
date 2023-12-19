local new(name, server='127.0.0.1', port=6443, default_ns='default') = {
  apiVersion: 'tanka.dev/v1alpha1',
  kind: 'Environment',
  metadata: {
    name: 'environment/%s' % name,
  },
  spec: {
    apiServer: 'https://%s:%d' % [server, port],
    namespace: default_ns,
    resourceDefaults: {},
    expectVersions: {},
  },
  data: {},
};

local withData(data) = {
  data+: data,
};

{
  new:: new,
  withData:: withData,
}
