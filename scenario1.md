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
