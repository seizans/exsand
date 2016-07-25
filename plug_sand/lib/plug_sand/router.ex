defmodule PlugSand.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/hello" do
    PlugSand.Handler.hello(conn)
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
