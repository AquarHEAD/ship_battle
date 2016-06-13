defmodule ShipBattle.Mixfile do
  use Mix.Project

  def project do
    [app: :ship_battle,
     version: "0.1.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :gproc],
     mod: {ShipBattle, []}]
  end

  defp deps do
    [{:gproc, "~> 0.5"}]
  end
end
