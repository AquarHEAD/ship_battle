defmodule ShipBattle.Ship.Supervisor do
  use Supervisor

  @name ShipBattle.Ship.Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def start_ship(id) do
    Supervisor.start_child(@name, [id])
  end

  def init(:ok) do
    child = worker(ShipBattle.Ship, [], restart: :transient)

    supervise([child], strategy: :simple_one_for_one)
  end
end
