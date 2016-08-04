defmodule Phsand.Controller do
  defmacro __using__([]) do
    quote do
      use Phoenix.Controller
      import Phsand.Router.Helpers
    end
  end
end
