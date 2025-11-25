# security/spire-config/spire-server-config.hcl
# WHY: SPIRE server config for HCL-based deploy (demo). In production, secure config + CA storage required.
server {
  bind_address = "0.0.0.0"
  bind_port = 8081
  # ... more production-grade settings
}
plugins {
  DataStore "sql" {
    plugin_data {
      # configure DB for persistence in production
    }
  }
}
