{
  apiVersion: 'v1',
  data: {
    'loki.yaml': 'YXV0aF9lbmFibGVkOiBmYWxzZQpjaHVua19zdG9yZV9jb25maWc6CiAgbWF4X2xvb2tfYmFja19wZXJpb2Q6IDAKaW5nZXN0ZXI6CiAgY2h1bmtfYmxvY2tfc2l6ZTogMjYyMTQ0CiAgY2h1bmtfaWRsZV9wZXJpb2Q6IDNtCiAgY2h1bmtfcmV0YWluX3BlcmlvZDogMW0KICBsaWZlY3ljbGVyOgogICAgcmluZzoKICAgICAga3ZzdG9yZToKICAgICAgICBzdG9yZTogaW5tZW1vcnkKICAgICAgcmVwbGljYXRpb25fZmFjdG9yOiAxCiAgbWF4X3RyYW5zZmVyX3JldHJpZXM6IDAKbGltaXRzX2NvbmZpZzoKICBlbmZvcmNlX21ldHJpY19uYW1lOiBmYWxzZQogIHJlamVjdF9vbGRfc2FtcGxlczogdHJ1ZQogIHJlamVjdF9vbGRfc2FtcGxlc19tYXhfYWdlOiAxNjhoCnNjaGVtYV9jb25maWc6CiAgY29uZmlnczoKICAtIGZyb206ICIyMDE4LTA0LTE1IgogICAgaW5kZXg6CiAgICAgIHBlcmlvZDogMTY4aAogICAgICBwcmVmaXg6IGluZGV4XwogICAgb2JqZWN0X3N0b3JlOiBmaWxlc3lzdGVtCiAgICBzY2hlbWE6IHY5CiAgICBzdG9yZTogYm9sdGRiCnNlcnZlcjoKICBodHRwX2xpc3Rlbl9wb3J0OiAzMTAwCnN0b3JhZ2VfY29uZmlnOgogIGJvbHRkYjoKICAgIGRpcmVjdG9yeTogL2RhdGEvbG9raS9pbmRleAogIGZpbGVzeXN0ZW06CiAgICBkaXJlY3Rvcnk6IC9kYXRhL2xva2kvY2h1bmtzCnRhYmxlX21hbmFnZXI6CiAgcmV0ZW50aW9uX2RlbGV0ZXNfZW5hYmxlZDogZmFsc2UKICByZXRlbnRpb25fcGVyaW9kOiAw',
  },
  kind: 'Secret',
  metadata: {
    labels: {
      app: 'loki',
      chart: 'loki-0.25.1',
      heritage: 'Helm',
      release: 'loki',
    },
    name: 'loki',
    namespace: 'default',
  },
}
