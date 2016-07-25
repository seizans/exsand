defmodule Phsand.HelloController do
  use Phsand.Web, :controller

  def hello(conn, params) do
    conn
    |> json(%{foo: :bar})
  end

  def post(conn, params) do
    conn
    |> json(%{mado: :homu})
  end
end
