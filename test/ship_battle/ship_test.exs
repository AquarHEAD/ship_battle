defmodule ShipBattle.ShipTest do
  use ExUnit.Case

  @ship_id 123

  setup_all do
    :syn.init
    ShipBattle.Ship.Supervisor.start_ship @ship_id

    :ok
  end

  test "starting another Ship with same id should fail" do
    assert {:error, :taken} == ShipBattle.Ship.Supervisor.start_ship @ship_id
  end
end
