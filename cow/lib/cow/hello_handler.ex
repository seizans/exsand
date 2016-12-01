defmodule Cow.HelloHandler do
  @behaviour :cowboy_handler

  def init(req, opts) do
    headers = [{"content-type", "application/json"}]
    body = %{foo: "hello", bar: 35, baz: true, mado: nil, homu: ""}
           |> Poison.encode!()
    req2 = :cowboy_req.reply(200, headers, body, req)
    {:ok, req2, opts}
  end
end
