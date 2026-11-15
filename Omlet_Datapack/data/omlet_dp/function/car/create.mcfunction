# Spawns a car where the caller is standing, facing the way they're looking. It goes through the same setup as
# placing a car item: a stand wearing the car item from loot_table/car/<car> is turned into the car by car/setup
#
# Macro arguments:
#   car - the car's loot table under loot_table/car/ (e.g. mustang)
#
# Usage: /function omlet_dp:car/create {car:"mustang"}
summon armor_stand ~ ~ ~ {Tags:["omlet.car_spawning"],Invisible:1b,NoGravity:1b}
$loot replace entity @n[type=armor_stand,tag=omlet.car_spawning] armor.head loot omlet_dp:car/$(car)

# The loot table gives the placeable item; the car itself is the head item inside its entity_data
data modify entity @n[type=armor_stand,tag=omlet.car_spawning] equipment.head set from entity @n[type=armor_stand,tag=omlet.car_spawning] equipment.head.components."minecraft:entity_data".equipment.head
# setup turns the car to face away from the stand, so face the stand towards the caller
execute rotated as @s rotated ~180 0 as @n[type=armor_stand,tag=omlet.car_spawning] positioned as @s run function omlet_dp:car/setup
