# Run as and at a player standing in a portal, waiting to travel
scoreboard players add @s omlet.portal_timer 1
execute unless predicate omlet_dp:flatworld_portal/in_portal run return run function omlet_dp:multiblock/flatworld_portal/travel/cancel
execute if predicate omlet_dp:flatworld_portal/travel_blocked run return run function omlet_dp:multiblock/flatworld_portal/travel/fail {message:"Travel to the Flatworld is currently disabled"}
execute if score @s omlet.portal_timer matches 200.. run return run function omlet_dp:multiblock/flatworld_portal/travel/fail {message:"The destination failed to load"}

execute if score @s omlet.portal_dest matches 1 run title @s actionbar {"text":"Travelling to the Flatworld...","color":"green"}
execute if score @s omlet.portal_dest matches 0 run title @s actionbar {"text":"Travelling to the Overworld...","color":"green"}

# After 2 seconds, travel (travel/arrive waits for the destination to load first)
execute if score @s omlet.portal_timer matches 40.. run function omlet_dp:multiblock/flatworld_portal/travel/with_args {run:"arrive"}
