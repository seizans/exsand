defmodule Phalanx.Mixfile do
  use Mix.Project

  def project do
    [app: :phalanx,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger],
     mod: {Phalanx.Application, []}]
  end

  defp deps do
    [{:cowboy, github: "ninenines/cowboy", tag: "2.0.0-pre.6"},
     {:poison, "~> 3.1"},
     {:httpoison, "~> 0.11"},
     {:credo, "~> 0.5.3", runtime: false, only: [:dev, :test]},
     {:distillery, "~> 1.1.0", runtime: false}]
  end
end
