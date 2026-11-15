# Run as a just-placed industrial light item frame, positioned at the centre of its block.
# The frame's rotation says which surface it was placed on: up at pitch -90, down at 90; on walls south at yaw 0, west 90, north 180, east -90

# Space already taken: give the item back
execute unless block ~ ~ ~ #minecraft:air unless block ~ ~ ~ minecraft:water run loot spawn ~ ~ ~ loot omlet_dp:industrial_light
execute unless block ~ ~ ~ #minecraft:air unless block ~ ~ ~ minecraft:water run return run kill @s

execute if block ~ ~ ~ minecraft:water run setblock ~ ~ ~ minecraft:light[level=15,waterlogged=true]
execute unless block ~ ~ ~ minecraft:light run setblock ~ ~ ~ minecraft:light[level=15]

# The model, turned so its top (the lit face) points away from the surface
summon minecraft:item_display ~ ~ ~ {Tags:["omlet.industrial_light"],item:{id:"minecraft:stone",components:{"minecraft:item_model":"omlet_rp:industrial_light"}},brightness:{sky:15,block:15}}
execute if entity @s[x_rotation=90] run data modify entity @n[type=minecraft:item_display,tag=omlet.industrial_light,distance=..0.1] transformation.left_rotation set value [1f,0f,0f,0f]
execute if entity @s[x_rotation=0,y_rotation=-44..44] run data modify entity @n[type=minecraft:item_display,tag=omlet.industrial_light,distance=..0.1] transformation.left_rotation set value [0.7071068f,0f,0f,0.7071068f]
execute if entity @s[x_rotation=0,y_rotation=46..134] run data modify entity @n[type=minecraft:item_display,tag=omlet.industrial_light,distance=..0.1] transformation.left_rotation set value [0f,0f,0.7071068f,0.7071068f]
execute if entity @s[x_rotation=0] unless entity @s[y_rotation=-135..135] run data modify entity @n[type=minecraft:item_display,tag=omlet.industrial_light,distance=..0.1] transformation.left_rotation set value [-0.7071068f,0f,0f,0.7071068f]
execute if entity @s[x_rotation=0,y_rotation=-134..-46] run data modify entity @n[type=minecraft:item_display,tag=omlet.industrial_light,distance=..0.1] transformation.left_rotation set value [0f,0f,-0.7071068f,0.7071068f]
execute as @n[type=minecraft:item_display,tag=omlet.industrial_light,distance=..0.1] store result score @s omlet.light_timer run random value 40..400

# Hitbox to punch: a thin slab on floors and ceilings, a cube on walls (interactions can't be thin sideways)
execute if entity @s[x_rotation=-90] run summon minecraft:interaction ~ ~-.5 ~ {Tags:["omlet.industrial_light"],width:0.875f,height:0.1875f}
execute if entity @s[x_rotation=90] run summon minecraft:interaction ~ ~.3125 ~ {Tags:["omlet.industrial_light"],width:0.875f,height:0.1875f}
execute if entity @s[x_rotation=0] run summon minecraft:interaction ~ ~-.4375 ~ {Tags:["omlet.industrial_light"],width:0.875f,height:0.875f}

playsound minecraft:block.copper_bulb.turn_on block @a ~ ~ ~
kill @s
