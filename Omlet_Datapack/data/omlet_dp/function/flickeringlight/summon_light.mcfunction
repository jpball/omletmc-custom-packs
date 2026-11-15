# Run as and at a placed industrial light item frame. Its rotation gives which surface it was placed on.
execute align xyz positioned ~.5 ~.5 ~.5 unless block ~ ~ ~ #minecraft:air unless block ~ ~ ~ minecraft:water run return run function omlet_dp:flickeringlight/cancel_place

execute align xyz positioned ~.5 ~.5 ~.5 if block ~ ~ ~ minecraft:water run setblock ~ ~ ~ minecraft:light[level=15,waterlogged=true]
execute align xyz positioned ~.5 ~.5 ~.5 unless block ~ ~ ~ minecraft:light run setblock ~ ~ ~ minecraft:light[level=15]

# Rotate the model so its top (the lit face) points away from the surface. Frames face up at pitch -90, down at 90; wall frames face south at yaw 0, west 90, north 180, east -90
execute if entity @s[x_rotation=-90] align xyz positioned ~.5 ~.5 ~.5 run summon minecraft:item_display ~ ~ ~ {Tags:["omlet.industrial_light","omlet.new"],item:{id:"minecraft:stone",components:{"minecraft:item_model":"omlet_rp:industrial_light"}},brightness:{sky:15,block:15},transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1f,1f,1f]}}
execute if entity @s[x_rotation=90] align xyz positioned ~.5 ~.5 ~.5 run summon minecraft:item_display ~ ~ ~ {Tags:["omlet.industrial_light","omlet.new"],item:{id:"minecraft:stone",components:{"minecraft:item_model":"omlet_rp:industrial_light"}},brightness:{sky:15,block:15},transformation:{left_rotation:[1f,0f,0f,0f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1f,1f,1f]}}
execute if entity @s[x_rotation=0] unless entity @s[y_rotation=-135..135] align xyz positioned ~.5 ~.5 ~.5 run summon minecraft:item_display ~ ~ ~ {Tags:["omlet.industrial_light","omlet.new"],item:{id:"minecraft:stone",components:{"minecraft:item_model":"omlet_rp:industrial_light"}},brightness:{sky:15,block:15},transformation:{left_rotation:[-0.7071068f,0f,0f,0.7071068f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1f,1f,1f]}}
execute if entity @s[x_rotation=0,y_rotation=-44..44] align xyz positioned ~.5 ~.5 ~.5 run summon minecraft:item_display ~ ~ ~ {Tags:["omlet.industrial_light","omlet.new"],item:{id:"minecraft:stone",components:{"minecraft:item_model":"omlet_rp:industrial_light"}},brightness:{sky:15,block:15},transformation:{left_rotation:[0.7071068f,0f,0f,0.7071068f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1f,1f,1f]}}
execute if entity @s[x_rotation=0,y_rotation=46..134] align xyz positioned ~.5 ~.5 ~.5 run summon minecraft:item_display ~ ~ ~ {Tags:["omlet.industrial_light","omlet.new"],item:{id:"minecraft:stone",components:{"minecraft:item_model":"omlet_rp:industrial_light"}},brightness:{sky:15,block:15},transformation:{left_rotation:[0f,0f,0.7071068f,0.7071068f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1f,1f,1f]}}
execute if entity @s[x_rotation=0,y_rotation=-134..-46] align xyz positioned ~.5 ~.5 ~.5 run summon minecraft:item_display ~ ~ ~ {Tags:["omlet.industrial_light","omlet.new"],item:{id:"minecraft:stone",components:{"minecraft:item_model":"omlet_rp:industrial_light"}},brightness:{sky:15,block:15},transformation:{left_rotation:[0f,0f,-0.7071068f,0.7071068f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1f,1f,1f]}}

# Hitbox to punch: a thin slab on floors and ceilings, a cube on walls (interactions can't be thin sideways)
execute if entity @s[x_rotation=-90] align xyz positioned ~.5 ~ ~.5 run summon minecraft:interaction ~ ~ ~ {Tags:["omlet.industrial_light"],width:0.875f,height:0.1875f}
execute if entity @s[x_rotation=90] align xyz positioned ~.5 ~.8125 ~.5 run summon minecraft:interaction ~ ~ ~ {Tags:["omlet.industrial_light"],width:0.875f,height:0.1875f}
execute if entity @s[x_rotation=0] align xyz positioned ~.5 ~.0625 ~.5 run summon minecraft:interaction ~ ~ ~ {Tags:["omlet.industrial_light"],width:0.875f,height:0.875f}

execute as @e[type=minecraft:item_display,tag=omlet.new] run function omlet_dp:flickeringlight/next_flicker
tag @e[type=minecraft:item_display,tag=omlet.new] remove omlet.new

playsound minecraft:block.copper_bulb.turn_on block @a ~ ~ ~
kill @s
