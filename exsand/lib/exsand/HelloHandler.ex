defmodule Exsand.HelloHandler do
  @behaviour :cowboy_handler

  def init(req, opts) do
    req2 = :cowboy_req.reply 200,
                             [{"content-type", "text/plain"}],
                             "Hello",
                             req
    {:ok, req2, opts}
  end
end
