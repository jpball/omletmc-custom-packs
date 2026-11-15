# Runs as a car's hitbox when a player left-clicks it: an empty car turns back into its item
data remove entity @s attack
execute on vehicle on passengers on passengers if entity @s[type=player] run return 0
execute on vehicle at @s run function omlet_dp:car/pick_up
