{
  local lokiCanary = self,

  config:: {
    name: error 'must provide name',
    namespace: error 'must provide namespace',
    image: error 'must provide image',
    version: error 'must provide version',

    loki: {
      addresses: error 'must provide loki addresses',
    },

    commonLabels:: {
      'app.kubernetes.io/name': 'promtail',
      'app.kubernetes.io/instance': lokiCanary.config.name,
      'app.kubernetes.io/version': lokiCanary.config.version,
      'app.kubernetes.io/component': 'log-collector',
      'app.kubernetes.io/part-of': 'loki',
    },

    podLabelSelector:: {
      [labelName]: lokiCanary.config.commonLabels[labelName]
      for labelName in std.objectFields(lokiCanary.config.commonLabels)
      if !std.setMember(labelName, ['app.kubernetes.io/version'])
    },
  },

  daemonset: {
    apiVersion: 'apps/v1',
    kind: 'DaemonSet',
    metadata: {
      name: lokiCanary.config.name,
      namespace: lokiCanary.config.namespace,
    },
    spec: {
      selector: {
        matchLabels: lokiCanary.config.podLabelSelector,
      },
      template: {
        metadata: {
          labels: lokiCanary.config.commonLabels,
        },
        spec: {
          containers: [
            {
              name: 'loki-canary',
              image: lokiCanary.config.image,
              args: [
                '-labelname=instance',
                '-labelvalue=$(POD_NAME)',
                '-port=8080',
                '-addr=' + lokiCanary.config.loki.addr,
              ],
              ports: [
                {
                  containerPort: 80,
                  name: 'http-metrics',
                },
              ],
              resources: {
                requests: {
                  cpu: '10m',
                  memory: '20Mi',
                },
              },
              env: [
                {
                  name: 'HOSTNAME',
                  valueFrom: {
                    fieldRef: {
                      fieldPath: 'spec.nodeName',
                    },
                  },
                },
                {
                  name: 'POD_NAME',
                  valueFrom: {
                    fieldRef: {
                      fieldPath: 'metadata.name',
                    },
                  },
                },
              ],
            },
          ],
        },
      },
    },
  },
}
