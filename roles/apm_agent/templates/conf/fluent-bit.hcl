vault {
  address = "{{ vault_addr }}"
  renew_token = true
  ssl {
    # ...
  }
}

exec {
  splay = "5s"
  env {
    pristine = false
{% if fluent_bit_http_proxy is defined %}
    custom = ["HTTP_PROXY={{ fluent_bit_http_proxy }}"]
{% endif %}
  }
  reload_signal = "SIGHUP"
  kill_signal = "SIGINT"
  kill_timeout = "2s"
}