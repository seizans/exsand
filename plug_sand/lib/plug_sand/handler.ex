defmodule PlugSand.Handler do
  import Plug.Conn

  def dispatch(conn) do
    conn
    |> send_resp(200, "dispatch")
  end
end
