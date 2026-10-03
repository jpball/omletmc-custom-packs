# /function omlet_dp:multiblock/flatworld_portal/return_players {targets:"<players>"}
# e.g. {targets:"@a"} or {targets:"Steve"}. Sends any of them in the flatworld to the overworld surface at the same X/Z
$execute as $(targets) at @s if dimension omlet_dp:flatworld run function omlet_dp:multiblock/flatworld_portal/return/player
