defmodule Exsand.Mixfile do
  use Mix.Project

  def project do
    [app: :exsand,
     version: "0.0.1",
     elixir: "~> 1.3",
     test_coverage: [tool: Coverex.Task, log: :debug],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger,
                    :cowboy],
     mod: {Exsand, []}]
  end

  # Type "mix help deps" for more examples and options
  defp deps do
    [{:credo, "~> 0.5.3"},
     {:coverex, "~> 1.4.10", only: :test},
     {:httpoison, "~> 0.10.0", only: [:dev, :test]},
     {:poolboy, "~> 1.5.1"},
     {:eredis, "~> 1.0.8"},
     {:jsone, "~> 1.4.0"},
     {:ranch, override: true, github: "ninenines/ranch", ref: "master"},
     {:cowlib, override: true, github: "ninenines/cowlib", ref: "master"},
     {:gun, github: "ninenines/gun", ref: "c747a613ec28c4835b33ffd924a390ee55f3cf03", only: [:dev, :test]},
     {:cowboy, github: "ninenines/cowboy", ref: "7b248e5163fd852d6defe967318da849433dadb1"}]
  end
end
