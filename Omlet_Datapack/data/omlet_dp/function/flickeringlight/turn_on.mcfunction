# Run as and at a lamp display that is flickered off
tag @s remove omlet.light_off
function omlet_dp:flickeringlight/set_level {level:15}
data merge entity @s {brightness:{sky:15,block:15}}
playsound minecraft:block.copper_bulb.turn_on block @a ~ ~ ~ 0.3 1.8

# Half the time flicker again almost straight away, so flickers come in bursts
execute store result score #burst omlet.light run random value 0..1
execute if score #burst omlet.light matches 1 store result score @s omlet.light_timer run random value 2..8
execute if score #burst omlet.light matches 0 run function omlet_dp:flickeringlight/next_flicker
