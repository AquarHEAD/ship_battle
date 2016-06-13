# ShipBattle

## Overview

The project is generated with `mix new --sup`.

Root Supervisor will supervise 3 sub-supervisor, for Ship, Player and WebSocket respectively.

Client connect via WebSocket, commands are verified in WebSocket process, then send to Player process, then Ship.
