import Config

config :elixir_bet,
  ecto_repos: [ElixirBet.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :elixir_bet, ElixirBetWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: ElixirBetWeb.ErrorHTML, json: ElixirBetWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ElixirBet.PubSub,
  live_view: [signing_salt: "0EIC35K+"]


config :elixir_bet, ElixirBet.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  elixir_bet: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.0",
  elixir_bet: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

# Configuring ElixirBet.Repo to use superuser credentials
config :elixir_bet, ElixirBet.Repo,
  username: "petroyahi@gmail.com",
  password: "Incorrect@123",
  database: "elixir_bet_dev",
  hostname: "localhost",
  port: 5432,
  pool_size: 10

import_config "#{config_env()}.exs"
