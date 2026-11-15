function omlet_dp:day_message_broadcast/init
function omlet_dp:multiblock/flatworld_portal/init
function omlet_dp:gun/init
function omlet_dp:flickeringlight/init
function omlet_dp:car/init
function omlet_dp:player_saddle/init

# Re-grant advancement/unlock_recipes to everyone online, so recipes added since they last got it are unlocked too
advancement revoke @a only omlet_dp:unlock_recipes


tellraw @a {"text":"Omlet Datapack loaded successfully!","color":"light_purple","bold":true}
tellraw @a {"text": "- Current version no. 26.3_10.3", "color":"light_purple"}
