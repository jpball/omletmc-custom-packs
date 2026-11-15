# Runs as the driver of the car running car/drive, and records which keys they're holding
scoreboard players set #driver omlet.car 1
execute if predicate omlet_dp:controls/forward run scoreboard players add #throttle omlet.car 1
execute if predicate omlet_dp:controls/backward run scoreboard players remove #throttle omlet.car 1
execute if predicate omlet_dp:controls/left run scoreboard players add #steer omlet.car 1
execute if predicate omlet_dp:controls/right run scoreboard players remove #steer omlet.car 1
execute if predicate omlet_dp:controls/handbrake run scoreboard players set #brake omlet.car 1
execute if predicate omlet_dp:controls/horn run scoreboard players set #horn omlet.car 1
