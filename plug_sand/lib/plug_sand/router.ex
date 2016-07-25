defmodule PlugSand.Router do
  use Plug.Router
  use Plug.ErrorHandler

  plug Plug.Logger
  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  plug :match
  plug :dispatch

  get "/hello" do
    PlugSand.Handler.hello(conn)
  end

  post "/helloo" do
    IO.inspect conn
    IO.inspect conn.params
    PlugSand.Handler.post(conn)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack} = params) do
    IO.inspect params
    send_resp(conn, conn.status, "Something went wrong")
  end
end
