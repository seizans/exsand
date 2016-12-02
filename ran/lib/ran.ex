defmodule Ran do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    :ok = start_ranch()
    children = [
    ]
    opts = [strategy: :one_for_one, name: Ran.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp start_ranch() do
    {:ok, _} = :ranch.start_listener(:ran, 100, :ranch_tcp,
                                     [{:port, 5555}],
                                     Ran.Echo, [])
    :ok
  end
end
