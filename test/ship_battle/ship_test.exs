defmodule ShipBattle.ShipTest do
  use ExUnit.Case

  @ship_id 123

  setup_all do
    @ship_id
    |> ShipBattle.Ship.Supervisor.start_ship

    :ok
  end
end
