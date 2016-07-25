defmodule PlugSand.Mixfile do
  use Mix.Project

  def project do
    [app: :plug_sand,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [mod: {PlugSand, []},
     applications: [:logger,
                    :plug,
                    :poison,
                    :cowboy]]
  end

  defp deps do
    [{:plug, "~> 1.2.0-rc"},
     {:poison, "~> 2.2"},
     {:cowboy, "~> 1.0"}]
  end
end
