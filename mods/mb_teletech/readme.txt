The Teletech mod:
Down + "F" : Switch between "Green save" and "Orange save"
"G" : Save location
"F" : Teleport to location


Only use the teleport function when on the planet that has the location saved. You cannot teleport from the ship to the planet. Sadness will happen.

Installation:

Extract contents to
    Steam/steamapps/common/Starbound/mods/mb_teletech

Add "../mods/mb_teletech" to your bootstrap.config

Edit player.config in the assets folder and edit the line 27 (defaultItems). It should look like this: 
"defaultItems" : [{ "item" : "mb_teletech" }],

Now go to the tech panel in your ship and you will find it there.

bootstrap.config can be found:

Windows - Steam/steamapps/common/Starbound/win32
Linux (32 bit) - Steam/steamapps/common/Starbound/linux 32
Linuz (64 bit) - Steam/steamapps/common/Starbound/linux64
Mac - Steam/steamapps/common/Starbound/Starbound.app/Contents/MacOS

It should look like this:

{
  "assetSources" : [
    "../assets",
	"../mods/mb_teletech"
  ],
  "modSource" : "../mods",
  "storageDirectory" : ".."
}