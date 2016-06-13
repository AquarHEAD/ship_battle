defmodule ShipBattle.Ship do
  use GenServer

  # API

  def start_link(id) do
    GenServer.start_link(__MODULE__, id)
  end

  # GenServer Callbacks

  def init(id) do
    # TODO: load ship config from DB?

    # register in gproc
    :gproc.add_local_name({:ship, id})

    # initialize state
    {:ok, id}
  end
end
