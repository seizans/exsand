use Mix.Config

config :exsand,
  redis_pool_size: 32,
  redis_max_overflow: 0,
  redis_host: '127.0.0.1',
  redis_port: 6379,
  redis_database: 0

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
