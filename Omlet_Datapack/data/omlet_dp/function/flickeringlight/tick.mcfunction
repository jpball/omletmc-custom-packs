# Turn freshly placed (invisible) item frames into lamps
execute as @e[type=minecraft:item_frame,tag=omlet.industrial_light_placer] at @s align xyz positioned ~.5 ~.5 ~.5 run function omlet_dp:flickeringlight/summon_light

# Shift-right-clicked lamps switch on/off
execute as @e[type=minecraft:interaction,tag=omlet.industrial_light] if data entity @s interaction at @s run function omlet_dp:flickeringlight/use

# Punched lamps break
execute as @e[type=minecraft:interaction,tag=omlet.industrial_light] if data entity @s attack at @s run function omlet_dp:flickeringlight/hit

execute as @e[type=minecraft:item_display,tag=omlet.industrial_light] at @s run function omlet_dp:flickeringlight/lamp_tick
