defmodule PlugSand.Handler do
  import Plug.Conn

  def hello(conn) do
    conn
    |> send_resp(200, "hellooooooooo")
  end
end
