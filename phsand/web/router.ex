defmodule Phsand.Router do
  use Phsand.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Phsand do
    pipe_through :api

    get "/hello", HelloController, :hello
    post "/hello", HelloController, :post
  end
end
