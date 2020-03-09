{
  apiVersion: 'v1',
  data: {
    'promtail.yaml': "client:\n  backoff_config:\n    maxbackoff: 5s\n    maxretries: 20\n    minbackoff: 100ms\n  batchsize: 102400\n  batchwait: 1s\n  external_labels: {}\n  timeout: 10s\npositions:\n  filename: /run/promtail/positions.yaml\nserver:\n  http_listen_port: 3101\ntarget_config:\n  sync_period: 10s\nscrape_configs:\n- job_name: kubernetes-pods-name\n  pipeline_stages:\n    - docker: {}\n  kubernetes_sd_configs:\n  - role: pod\n  relabel_configs:\n  - source_labels:\n    - __meta_kubernetes_pod_label_name\n    target_label: __service__\n  - source_labels:\n    - __meta_kubernetes_pod_node_name\n    target_label: __host__\n  - action: drop\n    regex: ''\n    source_labels:\n    - __service__\n  - action: labelmap\n    regex: __meta_kubernetes_pod_label_(.+)\n  - action: replace\n    replacement: $1\n    separator: /\n    source_labels:\n    - __meta_kubernetes_namespace\n    - __service__\n    target_label: job\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_namespace\n    target_label: namespace\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_pod_name\n    target_label: instance\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_pod_container_name\n    target_label: container_name\n  - replacement: /var/log/pods/*$1/*.log\n    separator: /\n    source_labels:\n    - __meta_kubernetes_pod_uid\n    - __meta_kubernetes_pod_container_name\n    target_label: __path__\n- job_name: kubernetes-pods-app\n  pipeline_stages:\n    - docker: {}\n  kubernetes_sd_configs:\n  - role: pod\n  relabel_configs:\n  - action: drop\n    regex: .+\n    source_labels:\n    - __meta_kubernetes_pod_label_name\n  - source_labels:\n    - __meta_kubernetes_pod_label_app\n    target_label: __service__\n  - source_labels:\n    - __meta_kubernetes_pod_node_name\n    target_label: __host__\n  - action: drop\n    regex: ''\n    source_labels:\n    - __service__\n  - action: labelmap\n    regex: __meta_kubernetes_pod_label_(.+)\n  - action: replace\n    replacement: $1\n    separator: /\n    source_labels:\n    - __meta_kubernetes_namespace\n    - __service__\n    target_label: job\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_namespace\n    target_label: namespace\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_pod_name\n    target_label: instance\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_pod_container_name\n    target_label: container_name\n  - replacement: /var/log/pods/*$1/*.log\n    separator: /\n    source_labels:\n    - __meta_kubernetes_pod_uid\n    - __meta_kubernetes_pod_container_name\n    target_label: __path__\n- job_name: kubernetes-pods-direct-controllers\n  pipeline_stages:\n    - docker: {}\n  kubernetes_sd_configs:\n  - role: pod\n  relabel_configs:\n  - action: drop\n    regex: .+\n    separator: ''\n    source_labels:\n    - __meta_kubernetes_pod_label_name\n    - __meta_kubernetes_pod_label_app\n  - action: drop\n    regex: '[0-9a-z-.]+-[0-9a-f]{8,10}'\n    source_labels:\n    - __meta_kubernetes_pod_controller_name\n  - source_labels:\n    - __meta_kubernetes_pod_controller_name\n    target_label: __service__\n  - source_labels:\n    - __meta_kubernetes_pod_node_name\n    target_label: __host__\n  - action: drop\n    regex: ''\n    source_labels:\n    - __service__\n  - action: labelmap\n    regex: __meta_kubernetes_pod_label_(.+)\n  - action: replace\n    replacement: $1\n    separator: /\n    source_labels:\n    - __meta_kubernetes_namespace\n    - __service__\n    target_label: job\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_namespace\n    target_label: namespace\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_pod_name\n    target_label: instance\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_pod_container_name\n    target_label: container_name\n  - replacement: /var/log/pods/*$1/*.log\n    separator: /\n    source_labels:\n    - __meta_kubernetes_pod_uid\n    - __meta_kubernetes_pod_container_name\n    target_label: __path__\n- job_name: kubernetes-pods-indirect-controller\n  pipeline_stages:\n    - docker: {}\n  kubernetes_sd_configs:\n  - role: pod\n  relabel_configs:\n  - action: drop\n    regex: .+\n    separator: ''\n    source_labels:\n    - __meta_kubernetes_pod_label_name\n    - __meta_kubernetes_pod_label_app\n  - action: keep\n    regex: '[0-9a-z-.]+-[0-9a-f]{8,10}'\n    source_labels:\n    - __meta_kubernetes_pod_controller_name\n  - action: replace\n    regex: '([0-9a-z-.]+)-[0-9a-f]{8,10}'\n    source_labels:\n    - __meta_kubernetes_pod_controller_name\n    target_label: __service__\n  - source_labels:\n    - __meta_kubernetes_pod_node_name\n    target_label: __host__\n  - action: drop\n    regex: ''\n    source_labels:\n    - __service__\n  - action: labelmap\n    regex: __meta_kubernetes_pod_label_(.+)\n  - action: replace\n    replacement: $1\n    separator: /\n    source_labels:\n    - __meta_kubernetes_namespace\n    - __service__\n    target_label: job\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_namespace\n    target_label: namespace\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_pod_name\n    target_label: instance\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_pod_container_name\n    target_label: container_name\n  - replacement: /var/log/pods/*$1/*.log\n    separator: /\n    source_labels:\n    - __meta_kubernetes_pod_uid\n    - __meta_kubernetes_pod_container_name\n    target_label: __path__\n- job_name: kubernetes-pods-static\n  pipeline_stages:\n    - docker: {}\n  kubernetes_sd_configs:\n  - role: pod\n  relabel_configs:\n  - action: drop\n    regex: ''\n    source_labels:\n    - __meta_kubernetes_pod_annotation_kubernetes_io_config_mirror\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_pod_label_component\n    target_label: __service__\n  - source_labels:\n    - __meta_kubernetes_pod_node_name\n    target_label: __host__\n  - action: drop\n    regex: ''\n    source_labels:\n    - __service__\n  - action: labelmap\n    regex: __meta_kubernetes_pod_label_(.+)\n  - action: replace\n    replacement: $1\n    separator: /\n    source_labels:\n    - __meta_kubernetes_namespace\n    - __service__\n    target_label: job\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_namespace\n    target_label: namespace\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_pod_name\n    target_label: instance\n  - action: replace\n    source_labels:\n    - __meta_kubernetes_pod_container_name\n    target_label: container_name\n  - replacement: /var/log/pods/*$1/*.log\n    separator: /\n    source_labels:\n    - __meta_kubernetes_pod_annotation_kubernetes_io_config_mirror\n    - __meta_kubernetes_pod_container_name\n    target_label: __path__\n",
  },
  kind: 'ConfigMap',
  metadata: {
    labels: {
      app: 'promtail',
      chart: 'promtail-0.19.2',
      heritage: 'Helm',
      release: 'loki',
    },
    name: 'loki-promtail',
    namespace: 'default',
  },
}
