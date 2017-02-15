defmodule Phalanx.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    children = [
    ]
    opts = [strategy: :one_for_one, name: Phalanx.Supervisor]
    start_cowboy()
    Supervisor.start_link(children, opts)
  end

  defp start_cowboy() do
    dispatch = :cowboy_router.compile([
      {:_, [
            {"/hello",  Phalanx.HelloHandler, []},
            {"/google/location",  Phalanx.Google.LocationHandler, []},
            {"/google/callback",  Phalanx.Google.CallbackHandler, []},
           ]}
    ])
    {:ok, _} = :cowboy.start_clear(:phalanx,
                                   100,
                                   [{:ip, {0, 0, 0, 0}},
                                    {:port, 8080},
                                    {:max_connections, :infinity},
                                    {:backlog, 1024},
                                    {:nodelay, :true}],
                                   %{env: %{dispatch: dispatch}})
  end
end
