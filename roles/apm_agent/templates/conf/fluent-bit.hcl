vault {
  address = "{{ vault_addr }}"
  renew_token = true
  ssl {
    # ...
  }
}

template {
  source = "{{ apm_agent_home }}/bin/.env-template"
  destination = "{{ apm_agent_home }}/bin/.env"
  error_on_missing_key = false
  backup = true
  wait {
    min = "2s"
    max = "10s"
  }
}

exec {
  command = "{{ apm_agent_home }}/bin/fluent-bit -c {{ apm_agent_home }}/conf/fluent-bit.conf"
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