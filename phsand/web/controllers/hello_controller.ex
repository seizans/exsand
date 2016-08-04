defmodule Phsand.HelloController do
  use Phoenix.Controller
  import Phsand.Router.Helpers

  def hello(conn, _params) do
    conn
    |> json(%{foo: :bar})
  end

  def post(conn, _params) do
    conn
    |> json(%{mado: :homu})
  end
end
