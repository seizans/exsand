use Mix.Config

config :phsand, Phsand.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "k9+hee0WrQ1bhIqmxUlr28HHPQKGlgRuFKl+VpYVomx3hnhCK4/Sbyv7FoiUHkex",
  render_errors: [accepts: ~w(json)],
  pubsub: [name: Phsand.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# ファイル末尾から動かしてはいけない
import_config "#{Mix.env}.exs"
