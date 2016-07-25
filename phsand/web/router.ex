defmodule Phsand.Router do
  use Phsand.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Phsand do
    pipe_through :api
  end
end
