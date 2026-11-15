# /function omlet_dp:flatworld/send {targets:"<selector or name>"}
# Sends players to the flatworld, standing on the surface at the X/Z they're at. Players already there are left alone
$execute as $(targets) at @s unless dimension omlet_dp:flatworld in omlet_dp:flatworld run spreadplayers ~ ~ 0 1 false @s
