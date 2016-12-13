defmodule Chat.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    children = [
      worker(Chat.Room, []),
    ]
    opts = [strategy: :one_for_one, name: Chat.Supervisor]
    start_cowboy()
    Supervisor.start_link(children, opts)
  end

  defp start_cowboy() do
    dispatch = :cowboy_router.compile([
      {:_, [{"/hello", Chat.HelloHandler, []},
            {"/ws", Chat.WsHandler, []},
            {"/", :cowboy_static, {:priv_file, :chat, "static/index.html"}},
            {"/app.js", :cowboy_static, {:priv_file, :chat, "static/app.js"}},
           ]}
    ])
    {:ok, _} = :cowboy.start_http(:chat,
                                  100,
                                  [{:ip, {0, 0, 0, 0}},
                                   {:port, 8080},
                                   {:max_connections, :infinity},
                                   {:backlog, 1024},
                                   {:nodelay, :true}],
                                  [{:env, [{:dispatch, dispatch}]}])
  end
end
