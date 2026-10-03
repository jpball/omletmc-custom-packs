# /function omlet_dp:multiblock/flatworld_portal/disable_travel
# Players can still use portals to leave the flatworld
scoreboard players set #travel_enabled omlet.portal 0
tellraw @a {"text":"Portal travel to the Flatworld is now disabled","color":"red"}
