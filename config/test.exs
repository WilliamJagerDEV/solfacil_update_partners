import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :solfacil_update_partners, SolfacilUpdatePartners.Repo,
  username: "postgres",
  password: "26maio09",
  hostname: "localhost",
  database: "solfacil_update_partners_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :solfacil_update_partners, SolfacilUpdatePartnersWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "BA9+DPLsjz1nO10F57bdS4TbDKZO03RiKXqucScEhRT7u3dbmgniizCFWegzEkSx",
  server: false

# In test we don't send emails.
config :solfacil_update_partners, SolfacilUpdatePartners.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
