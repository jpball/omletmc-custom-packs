# Run as a player in the flatworld. Picks their spawn point, or the fallback from flatworld/return if they don't have one.
# A spawn point is the bed/anchor block (or where /spawnpoint was run), so arrive 1 block above it
data modify storage omlet_dp:flatworld spawn set from storage omlet_dp:flatworld fallback
execute if data entity @s respawn run data modify storage omlet_dp:flatworld spawn set value {dimension:"minecraft:overworld", up:1}
execute if data entity @s respawn.dimension run data modify storage omlet_dp:flatworld spawn.dimension set from entity @s respawn.dimension
execute if data entity @s respawn run data modify storage omlet_dp:flatworld spawn.x set from entity @s respawn.pos[0]
execute if data entity @s respawn run data modify storage omlet_dp:flatworld spawn.y set from entity @s respawn.pos[1]
execute if data entity @s respawn run data modify storage omlet_dp:flatworld spawn.z set from entity @s respawn.pos[2]
function omlet_dp:flatworld/return/teleport with storage omlet_dp:flatworld spawn
