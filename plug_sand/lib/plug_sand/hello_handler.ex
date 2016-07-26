defmodule PlugSand.HelloHandler do
  import Plug.Conn

  def hello(conn) do
    conn
    |> send_resp(200, "hellooooooooo")
  end

  def post(conn) do
    conn
    |> send_resp(200, "posttttt")
  end
end
