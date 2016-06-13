defmodule ShipBattle do
  use Application

  def start(_type, _args) do
    # Initialize syn (seems not working if before Node.connect)
    # :syn.init

    # Start ShipBattle supervision tree
    import Supervisor.Spec, warn: false

    children = [
      supervisor(ShipBattle.Ship.Supervisor, [])
    ]

    opts = [strategy: :one_for_one, name: ShipBattle.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
