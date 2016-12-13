defmodule Chat.Mixfile do
  use Mix.Project

  def project do
    [app: :chat,
     version: "0.1.0",
     elixir: "~> 1.4-rc",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger],
     mod: {Chat.Application, []}]
  end

  defp deps do
    [{:cowboy, github: "ninenines/cowboy", tag: "2.0.0-pre.3"},
     {:poison, "~> 3.0.0"},

     {:distillery, "~> 0.10.1"}]
  end
end
