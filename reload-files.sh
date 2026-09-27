#!/usr/bin/env bash
# Copies the datapack and resource pack into a Minecraft test world.
# Override any variable from the environment, e.g.:
#   WORLD_NAME="My Test World" ./reload-files.sh
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ -f "$SRC_DIR/.env" ]]; then
	source "$SRC_DIR/.env"
fi

MINECRAFT_DIR="${MINECRAFT_DIR:-$HOME/.minecraft}"
WORLD_NAME="${WORLD_NAME:-Test World}"
DATAPACK_DEST="${DATAPACK_DEST:-$MINECRAFT_DIR/saves/$WORLD_NAME/datapacks}"
RESOURCEPACK_DEST="${RESOURCEPACK_DEST:-$MINECRAFT_DIR/resourcepacks}"

sync_pack() {
	local name="$1" dest="$2"
	if [[ ! -d "$dest" ]]; then
		echo "Destination not found: $dest" >&2
		exit 1
	fi
	# Replace the whole folder so deleted/renamed files don't linger
	rm -rf "${dest:?}/$name"
	cp -r "$SRC_DIR/$name" "$dest/$name"
	echo "Copied $name -> $dest/$name"
}

sync_pack Omlet_Datapack "$DATAPACK_DEST"
sync_pack Omlet_ResourcePack "$RESOURCEPACK_DEST"

echo "Done. Run /reload in-game, and press F3+T to reload the resource pack."
