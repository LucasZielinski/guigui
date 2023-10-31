use Mix.Config

config :api, Api.Repo,
  username: "elixir",
  password: "elixir",
  database: "api_elixir",
  hostname: "database",
  port: 5432,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :api, ApiWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []
