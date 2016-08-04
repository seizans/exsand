defmodule Phsand.HelloController do
  use Phsand.Controller

  def hello(conn, _params) do
    conn
    |> json(%{foo: :bar})
  end

  def post(conn, _params) do
    conn
    |> json(%{mado: :homu})
  end
end
