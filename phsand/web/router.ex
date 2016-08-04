defmodule Phsand.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Phsand do
    pipe_through :api

    get  "/hello", HelloController, :hello
    post "/hello", HelloController, :post
  end
end
