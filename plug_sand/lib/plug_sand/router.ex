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
    json(conn, %{error: "#{media_type} is unsupported media type"})
  end
  defp handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack} = params) do
    Logger.info(params)
    json(conn, %{error: "Something went wrong"})
  end

  @spec json(Plug.Conn.t, map) :: Plug.Conn.t
  def json(conn, data) do
    send_resp(conn, conn.status || 200, "application/json", Poison.encode_to_iodata!(data))
  end

  defp send_resp(conn, default_status, default_content_type, body) do
    conn
    |> ensure_resp_content_type(default_content_type)
    |> send_resp(conn.status || default_status, body)
  end

  defp ensure_resp_content_type(%{resp_headers: resp_headers} = conn, content_type) do
    # headers は [{binary, binary}] なので List.keyfind を使う: https://hexdocs.pm/plug/Plug.Conn.html#t:headers/0
    if List.keyfind(resp_headers, "content-type", 0) do
      conn
    else
      content_type = "#{content_type}; charset=utf-8"
      %{conn | resp_headers: [{"content-type", content_type} | resp_headers]}
    end
  end
end
