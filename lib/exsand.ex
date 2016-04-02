defmodule Exsand do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Exsand.Worker, [arg1, arg2, arg3]),
    ]

    opts = [strategy: :one_for_one, name: Exsand.Supervisor]
    Supervisor.start_link(children, opts)

    dispatch = :cowboy_router.compile([
        {:_, [{"/", Exsand.HelloHandler, []}
             ]}
    ])
    {ok, _} = :cowboy.start_http(:exsand,
                                 100,
                                 [{:ip, {0, 0, 0, 0}},
                                  {:port, 8080},
                                  {:max_connections, :infinity},
                                  {:backlog, 1024},
                                  {:nodelay, :true}],
                                 [{:env, [{:dispatch, dispatch}]}])
  end
end
