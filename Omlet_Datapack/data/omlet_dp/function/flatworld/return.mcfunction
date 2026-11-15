# /function omlet_dp:flatworld/return {targets:"<selector or name>", x:<x>, y:<y>, z:<z>}
# Sends players in the flatworld to their spawn point: their bed, respawn anchor or /spawnpoint, in whichever dimension that is.
# Players without one go to x y z in the overworld (e.g. the world spawn). Players not in the flatworld are left alone
$data modify storage omlet_dp:flatworld fallback set value {dimension:"minecraft:overworld", x:$(x), y:$(y), z:$(z), up:0}
$execute as $(targets) at @s if dimension omlet_dp:flatworld run function omlet_dp:flatworld/return/player
