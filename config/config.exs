# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :solfacil_update_partners,
  ecto_repos: [SolfacilUpdatePartners.Repo]

# Configures the endpoint
config :solfacil_update_partners, SolfacilUpdatePartnersWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SolfacilUpdatePartnersWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SolfacilUpdatePartners.PubSub,
  live_view: [signing_salt: "RM8FZeW2"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :solfacil_update_partners, SolfacilUpdatePartners.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
