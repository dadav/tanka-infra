{
  local d = (import 'doc-util/main.libsonnet'),
  '#':: d.pkg(name='podSecurityContext', url='', help='"PodSecurityContext holds pod-level security attributes and common container settings. Some fields are also present in container.securityContext.  Field values of container.securityContext take precedence over field values of PodSecurityContext."'),
  '#seLinuxOptions':: d.obj(help='"SELinuxOptions are the labels to be applied to the container"'),
  seLinuxOptions: {
    '#withLevel':: d.fn(help='"Level is SELinux level label that applies to the container."', args=[d.arg(name='level', type=d.T.string)]),
    withLevel(level): { seLinuxOptions+: { level: level } },
    '#withRole':: d.fn(help='"Role is a SELinux role label that applies to the container."', args=[d.arg(name='role', type=d.T.string)]),
    withRole(role): { seLinuxOptions+: { role: role } },
    '#withType':: d.fn(help='"Type is a SELinux type label that applies to the container."', args=[d.arg(name='type', type=d.T.string)]),
    withType(type): { seLinuxOptions+: { type: type } },
    '#withUser':: d.fn(help='"User is a SELinux user label that applies to the container."', args=[d.arg(name='user', type=d.T.string)]),
    withUser(user): { seLinuxOptions+: { user: user } },
  },
  '#seccompProfile':: d.obj(help="\"SeccompProfile defines a pod/container's seccomp profile settings. Only one profile source may be set.\""),
  seccompProfile: {
    '#withLocalhostProfile':: d.fn(help="\"localhostProfile indicates a profile defined in a file on the node should be used. The profile must be preconfigured on the node to work. Must be a descending path, relative to the kubelet's configured seccomp profile location. Must only be set if type is \\\"Localhost\\\".\"", args=[d.arg(name='localhostProfile', type=d.T.string)]),
    withLocalhostProfile(localhostProfile): { seccompProfile+: { localhostProfile: localhostProfile } },
    '#withType':: d.fn(help='"type indicates which kind of seccomp profile will be applied. Valid options are:\\n\\nLocalhost - a profile defined in a file on the node should be used. RuntimeDefault - the container runtime default profile should be used. Unconfined - no profile should be applied."', args=[d.arg(name='type', type=d.T.string)]),
    withType(type): { seccompProfile+: { type: type } },
  },
  '#windowsOptions':: d.obj(help='"WindowsSecurityContextOptions contain Windows-specific options and credentials."'),
  windowsOptions: {
    '#withGmsaCredentialSpec':: d.fn(help='"GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."', args=[d.arg(name='gmsaCredentialSpec', type=d.T.string)]),
    withGmsaCredentialSpec(gmsaCredentialSpec): { windowsOptions+: { gmsaCredentialSpec: gmsaCredentialSpec } },
    '#withGmsaCredentialSpecName':: d.fn(help='"GMSACredentialSpecName is the name of the GMSA credential spec to use."', args=[d.arg(name='gmsaCredentialSpecName', type=d.T.string)]),
    withGmsaCredentialSpecName(gmsaCredentialSpecName): { windowsOptions+: { gmsaCredentialSpecName: gmsaCredentialSpecName } },
    '#withHostProcess':: d.fn(help="\"HostProcess determines if a container should be run as a 'Host Process' container. This field is alpha-level and will only be honored by components that enable the WindowsHostProcessContainers feature flag. Setting this field without the feature flag will result in errors when validating the Pod. All of a Pod's containers must have the same effective HostProcess value (it is not allowed to have a mix of HostProcess containers and non-HostProcess containers).  In addition, if HostProcess is true then HostNetwork must also be set to true.\"", args=[d.arg(name='hostProcess', type=d.T.boolean)]),
    withHostProcess(hostProcess): { windowsOptions+: { hostProcess: hostProcess } },
    '#withRunAsUserName':: d.fn(help='"The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."', args=[d.arg(name='runAsUserName', type=d.T.string)]),
    withRunAsUserName(runAsUserName): { windowsOptions+: { runAsUserName: runAsUserName } },
  },
  '#withFsGroup':: d.fn(help="\"A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:\\n\\n1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----\\n\\nIf unset, the Kubelet will not modify the ownership and permissions of any volume. Note that this field cannot be set when spec.os.name is windows.\"", args=[d.arg(name='fsGroup', type=d.T.integer)]),
  withFsGroup(fsGroup): { fsGroup: fsGroup },
  '#withFsGroupChangePolicy':: d.fn(help='"fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are \\"OnRootMismatch\\" and \\"Always\\". If not specified, \\"Always\\" is used. Note that this field cannot be set when spec.os.name is windows."', args=[d.arg(name='fsGroupChangePolicy', type=d.T.string)]),
  withFsGroupChangePolicy(fsGroupChangePolicy): { fsGroupChangePolicy: fsGroupChangePolicy },
  '#withRunAsGroup':: d.fn(help='"The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows."', args=[d.arg(name='runAsGroup', type=d.T.integer)]),
  withRunAsGroup(runAsGroup): { runAsGroup: runAsGroup },
  '#withRunAsNonRoot':: d.fn(help='"Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."', args=[d.arg(name='runAsNonRoot', type=d.T.boolean)]),
  withRunAsNonRoot(runAsNonRoot): { runAsNonRoot: runAsNonRoot },
  '#withRunAsUser':: d.fn(help='"The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container. Note that this field cannot be set when spec.os.name is windows."', args=[d.arg(name='runAsUser', type=d.T.integer)]),
  withRunAsUser(runAsUser): { runAsUser: runAsUser },
  '#withSupplementalGroups':: d.fn(help="\"A list of groups applied to the first process run in each container, in addition to the container's primary GID, the fsGroup (if specified), and group memberships defined in the container image for the uid of the container process. If unspecified, no additional groups are added to any container. Note that group memberships defined in the container image for the uid of the container process are still effective, even if they are not included in this list. Note that this field cannot be set when spec.os.name is windows.\"", args=[d.arg(name='supplementalGroups', type=d.T.array)]),
  withSupplementalGroups(supplementalGroups): { supplementalGroups: if std.isArray(v=supplementalGroups) then supplementalGroups else [supplementalGroups] },
  '#withSupplementalGroupsMixin':: d.fn(help="\"A list of groups applied to the first process run in each container, in addition to the container's primary GID, the fsGroup (if specified), and group memberships defined in the container image for the uid of the container process. If unspecified, no additional groups are added to any container. Note that group memberships defined in the container image for the uid of the container process are still effective, even if they are not included in this list. Note that this field cannot be set when spec.os.name is windows.\"\n\n**Note:** This function appends passed data to existing values", args=[d.arg(name='supplementalGroups', type=d.T.array)]),
  withSupplementalGroupsMixin(supplementalGroups): { supplementalGroups+: if std.isArray(v=supplementalGroups) then supplementalGroups else [supplementalGroups] },
  '#withSysctls':: d.fn(help='"Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch. Note that this field cannot be set when spec.os.name is windows."', args=[d.arg(name='sysctls', type=d.T.array)]),
  withSysctls(sysctls): { sysctls: if std.isArray(v=sysctls) then sysctls else [sysctls] },
  '#withSysctlsMixin':: d.fn(help='"Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch. Note that this field cannot be set when spec.os.name is windows."\n\n**Note:** This function appends passed data to existing values', args=[d.arg(name='sysctls', type=d.T.array)]),
  withSysctlsMixin(sysctls): { sysctls+: if std.isArray(v=sysctls) then sysctls else [sysctls] },
  '#mixin': 'ignore',
  mixin: self,
}
