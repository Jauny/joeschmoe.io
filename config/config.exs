# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :avatar,
  ecto_repos: [Avatar.Repo]

# Configures the endpoint
config :avatar, AvatarWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qABDg50yI5jTL88QBj2z9suYv+4NzuRwHPsoILNngReXHnDqXlzJ+RVz3bWwV1IZ",
  render_errors: [view: AvatarWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Avatar.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Kennex, the Keen.io lib
config :keenex,
  project_id: System.get_env("KEEN_PROJECT_ID"),
  read_key:   System.get_env("KEEN_READ_KEY"),
  write_key:  System.get_env("KEEN_WRITE_KEY"),
  httpoison_opts: [timeout: 5000]  # defaults to []

# by default, we dont track events
config :avatar, :event,
  active: false

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
