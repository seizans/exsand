defmodule PlugSand do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # TODO(seizans): port 番号を設定に切り出す
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, PlugSand.Router, [], port: 4000)
    ]
    opts = [strategy: :one_for_one, name: PlugSand.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
