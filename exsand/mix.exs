defmodule Exsand.Mixfile do
  use Mix.Project

  def project do
    [app: :exsand,
     version: "0.0.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger,
                    :poolboy,
                    :eredis,
                    :poison,
                    :ranch,
                    :cowlib,
                    :cowboy],
     mod: {Exsand, []}]
  end

  # Type "mix help deps" for more examples and options
  defp deps do
    [{:credo, "~> 0.5.3", only: [:dev]},
     {:httpoison, "~> 0.10.0", only: [:dev, :test]},
     {:poolboy, "~> 1.5.1"},
     {:eredis, "~> 1.0.8"},
     {:poison, "~> 3.0.0"},
     {:ranch, override: true, github: "ninenines/ranch", ref: "1.3.0"},
     {:cowlib, override: true, github: "ninenines/cowlib", ref: "8e6d0f462850a90bd8a60995f52027839288d038"},
     {:gun, github: "ninenines/gun", ref: "1.0.0-pre.1", only: [:dev, :test]},
     {:cowboy, github: "ninenines/cowboy", ref: "2.0.0-pre.3"}]
  end
end
