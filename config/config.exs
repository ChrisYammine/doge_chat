# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :doge_chat,
  ecto_repos: [DogeChat.Repo]

# Configures the endpoint
config :doge_chat, DogeChat.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YPpe7D2ojTJCwrkS0LrBJYr+P4VJF2qKp2WEkpdOtIdRfiU07S6ac/sXh0p+z5OV",
  render_errors: [view: DogeChat.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DogeChat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
