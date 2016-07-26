defmodule PlugSand.Handler do
  import Plug.Conn

  def dispatch(conn, params) do
    IO.inspect params
    header_name = "x-sand"
    case get_req_header(conn, header_name) do
      [header_value] ->
        IO.inspect header_value
        conn
        |> send_resp(200, "dispatch")
      [] ->
        conn
        |> send_resp(400, "dispatch")
    end
  end
end
