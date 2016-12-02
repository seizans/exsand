defmodule Ran.Mixfile do
  use Mix.Project

  def project do
    [app: :ran,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :ranch],
     mod: {Ran, []}]
  end

  defp deps do
    [{:ranch, github: "ninenines/ranch", tag: "1.3.0"},
     {:distillery, "~> 0.10.1"}]
  end
end
