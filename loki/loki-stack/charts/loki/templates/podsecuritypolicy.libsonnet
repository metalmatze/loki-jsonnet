{
  apiVersion: 'policy/v1beta1',
  kind: 'PodSecurityPolicy',
  metadata: {
    name: 'loki',
  },
  spec: {
    allowPrivilegeEscalation: false,
    fsGroup: {
      ranges: [
        {
          max: 65535,
          min: 1,
        },
      ],
      rule: 'MustRunAs',
    },
    hostIPC: false,
    hostNetwork: false,
    hostPID: false,
    privileged: false,
    readOnlyRootFilesystem: true,
    requiredDropCapabilities: [
      'ALL',
    ],
    runAsUser: {
      rule: 'MustRunAsNonRoot',
    },
    seLinux: {
      rule: 'RunAsAny',
    },
    supplementalGroups: {
      ranges: [
        {
          max: 65535,
          min: 1,
        },
      ],
      rule: 'MustRunAs',
    },
    volumes: [
      'configMap',
      'emptyDir',
      'persistentVolumeClaim',
      'secret',
    ],
  },
}
