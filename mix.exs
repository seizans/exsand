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

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger,
                    :cowboy],
     mod: {Exsand, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:exrm, "~> 1.0.3"},
     {:cowboy, github: "ninenines/cowboy", ref: "b7d666cfc746f55b0a72ef8d37f703885099daf7"}]
     #{:cowboy, github: "ninenines/cowboy", ref: "45158c1da454b5c7406418afeccaecf54232deeb"}]
  end
end
