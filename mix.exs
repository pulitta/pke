defmodule Pke.Mixfile do
  use Mix.Project

  def project do
    [app: :pke,
     version: "0.0.1",
     elixir: "~> 1.2",
     escript: [main_module: Pke],
     erlc_paths: ["test"],        # <- Erlang source files
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end
end
