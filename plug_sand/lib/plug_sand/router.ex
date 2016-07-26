defmodule PlugSand.Router do
  use Plug.Router
  use Plug.ErrorHandler

  require Logger

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

  defp handle_errors(conn, %{kind: :error, reason: %Plug.Parsers.UnsupportedMediaTypeError{media_type: media_type}}) do
    Logger.info("#{media_type} is unsupported media type")
    body = Poison.encode!(%{error: "#{media_type} is unsupported media type"})
    send_resp(conn, conn.status, body)
  end
  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack} = params) do
    Logger.info(params)
    body = Poison.encode!(%{error: "Something went wrong"})
    send_resp(conn, conn.status, body)
  end
end
