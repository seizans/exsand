defmodule Phalanx.HelloHandler do
  @behaviour :cowboy_handler
  require Logger

  @headers %{"content-type" => "application/json"}

  def init(req, [] = _opts) do
    body = %{hello: "world"} |> Poison.encode!()
    req = :cowboy_req.reply(200, @headers, body, req)
    {:ok, req, nil}
  end
end
