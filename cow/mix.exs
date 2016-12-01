defmodule Cow.Mixfile do
  use Mix.Project

  def project do
    [app: :cow,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :cowboy, :poison],
     mod: {Cow, []}]
  end

  defp deps do
    [{:cowboy, github: "ninenines/cowboy", tag: "2.0.0-pre.3"},
     {:poison, "~> 3.0.0"}]
  end
end
