defmodule ShipBattle.Ship do
  use GenServer

  # API

  def start_link(id) do
    GenServer.start_link(__MODULE__, id)
  end

  def take_damage(id, dmg) do
    target_pid = :gproc.lookup_local_name({:ship, id})
    GenServer.call(target_pid, {:take_damage, dmg})
  end

  # GenServer Callbacks

  def init(id) do
    # TODO: load ship config from DB?

    # register in gproc
    :gproc.add_local_name({:ship, id})

    # initialize state
    shield = %{
      hp: 450,
      capacity: 450,
      resist: %{
        em: 0,
        ther: 0.2,
        kin: 0.4,
        exp: 0.5
      }
    }

    ship_state = %{
      destroyed: false,
      id: id,
      shield: shield,
    }

    {:ok, ship_state}
  end

  # If ship is destroyed, ignore any message after
  def handle_call(_msg, _from, %{destroyed: true} = state), do: {:reply, :target_destroyed, state}

  def handle_call({:take_damage, dmg}, _from, %{shield: shield} = state) do
    total_dmg =
      dmg
      |> Enum.map(fn({dmg_type, dmg_value}) -> dmg_value * (1.0 - shield[:resist][dmg_type]) end)
      |> Enum.sum

    new_hp = max(shield[:hp] - total_dmg, 0)

    new_shield = %{shield | hp: new_hp}
    {:reply, total_dmg, %{state | destroyed: new_hp == 0, shield: new_shield}}
  end

  # If ship is destroyed, ignore any message after
  def handle_cast(_, %{destroyed: true} = state), do: {:noreply, state}

  def handle_cast({:take_damage, dmg}, %{shield: shield} = state) do
    total_dmg =
      dmg
      |> Enum.map(fn({dmg_type, dmg_value}) -> dmg_value * (1.0 - shield[:resist][dmg_type]) end)
      |> Enum.sum

    new_hp = max(shield[:hp] - total_dmg, 0)

    new_shield = %{shield | hp: new_hp}
    {:noreply, %{state | destroyed: new_hp == 0, shield: new_shield}}
  end
end
