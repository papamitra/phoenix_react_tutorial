use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :react_tutorial, ReactTutorial.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :react_tutorial, ReactTutorial.Repo,
  adapter: Mongo.Ecto,
  database: "react_tutorial_test",
  pool_size: 1
