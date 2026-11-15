# Per player: right-clicks with a carrot on a stick (the gun's base item), and ticks until they can fire again
scoreboard objectives add omlet.gun_used minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add omlet.gun_cooldown dummy

# Temporary values (fake players) used while tracing a shot
scoreboard objectives add omlet.gun dummy
scoreboard players set #2 omlet.gun 2
