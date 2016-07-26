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

  post "/", do: PlugSand.Handler.dispatch(conn)

  get "/hello" do
    PlugSand.HelloHandler.hello(conn)
  end

  post "/helloo" do
    IO.inspect conn
    IO.inspect conn.params
    PlugSand.HelloHandler.post(conn)
  end

  match _ do
    conn
    |> put_status(404)
    |> json(%{error: "NOT FOUND"})
  end

  defp handle_errors(conn, %{kind: :error, reason: %Plug.Parsers.UnsupportedMediaTypeError{media_type: media_type}}) do
    Logger.info("#{media_type} is unsupported media type")
    conn
    |> json(%{error: "#{media_type} is unsupported media type"})
  end
  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack} = params) do
    Logger.info(params)
    conn
    |> json(%{error: "Something went wrong"})
  end

  @spec json(Plug.Conn.t, map) :: Plug.Conn.t
  def json(conn, data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(conn.status || 200, Poison.encode_to_iodata!(data))
  end

end
