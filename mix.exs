defmodule Exsand.Mixfile do
  use Mix.Project

  def project do
    [app: :exsand,
     version: "0.0.1",
     elixir: "~> 1.2",
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
    [{:exrm, "~> 1.0.3"},
     {:httpoison, "~> 0.8.2", only: [:dev, :test]},
     {:poolboy, "~> 1.5.1"},
     {:eredis, "~> 1.0.8"},
     {:jsone, "~> 1.2.1"},
     {:ranch, override: true, github: "ninenines/ranch", ref: "master"},
     {:cowlib, override: true, github: "ninenines/cowlib", ref: "master"},
     {:gun, github: "ninenines/gun", ref: "d88f3675dba9e066ef339789d8c223358f744aac", only: [:dev, :test]},
     {:cowboy, github: "ninenines/cowboy", ref: "b7d666cfc746f55b0a72ef8d37f703885099daf7"}]
  end
end
