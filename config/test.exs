use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :doge_chat, DogeChat.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :doge_chat, DogeChat.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("POSTGRES_USERNAME"),
  password: System.get_env("POSTGRES_PASSWORD"),
  database: "doge_chat_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
