# ShipBattle

## Overview

The project is generated with `mix new --sup`.

Root Supervisor will supervise 3 sub-supervisor, for Ship, Player and WebSocket respectively.

Client connect via WebSocket, commands are verified in WebSocket process, then send to Player process, then Ship.

## Testing in iex

```elixir
# Connect to other nodes first
Node.connect :"node1@Mashiro"

# Then initialize Syn
:syn.init

# Play
iex(1)> ShipBattle.Ship.Supervisor.start_ship 123
{:ok, #PID<0.149.0>}
iex(2)> ShipBattle.Ship.take_damage(123, %{em: 120})
:ok
iex(3)> :observer.start
:ok
iex(4)> ShipBattle.Ship.take_damage(123, %{em: 400})
:ok
iex(5)> ShipBattle.Ship.take_damage(123, %{em: 400})
:ok
```
