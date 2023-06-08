This is my project for my final year in university

These are the music used:

https://www.youtube.com/watch?v=68xqKUSzB-w, 
https://www.youtube.com/watch?v=6bB3EILH_7o, 
https://www.youtube.com/watch?v=NOiMt5ip-4s, 
https://www.youtube.com/watch?v=SXRdCnSnOO8

I am not making any income from this project or resources.

The pixel art is all mine.

------------------------------------

To run the code:
Please install Godot 3.x


Open the project in Godot.

Click the top right corner to the video play icon on the rightmost
{
    type into Search:       World.tscn 

    You will see that this is from the directory:
    "World/Levels/World.tscn"
}

Open 'World.tscn'
Wait for the screen to load.

The game should begin

Press the middle bar to continue the dialogue.

-----------------------------------------

Sprites: these sprites are all mine
They are found in the folder: 'res://import/'

Thank you for your time.

----------- the rest will be a summary of the code in this folder-----------

> AutoLoad: These are all singleton variables used throughout the scripts
> blender: is a file that will hold anything from blender
> creatures: the scene of a creature sprite
> ForestObjects: contains all the pixel tree sprites
> import: contains all the files imported
> Interactaions: contains all the UI saved styles
> Menu 
    {
        > Bag: contains all the scripts to do with the bag panel
        > Creature_Option: Containes all the scripts to do with the creature panel
        > Menu_Panel: contains all the scripts to do with the menu panel
        All the various scripts works with the help.tscn
    }

> Opponent: Opponent.tscn will be the challenger sprite
> player: Ruby.tscn is the only scene that will be used here as the player and the NPC. as well as Ruby.gd
> Resources:
    {
        > Adventures: All the quest resources 
        > AdventureClasses: Adventure resources sub classes
        > Creatures: redudant creature resources
        > Inventory: all the Player resources instance
        > Items: all the Item classes and resources
        > NPC: all the NPC scenes and scripts
        > Random: everything do to with random creature generataion and creature instance
    }

> SAVED_GAME_FILES: empty for now but will upddate with resources as the game continues
> scripts: some early game scripts that may be in used
> test: test Items
> World:
    {
        > BattleUI: contains the Levels original sizes and scaled versions
        > camera: script for the interpolated camera to limit the user vision
        > forestdownloadAssets: all the forest assets
        > LevelAssets: any assets made from scratch, like the grass
        > Levels: all the levels the player will use
        > NPCBattleEncounter: anything to do with a challenger versus player
        > Transitions: Scripts for when the player leaves a level, enters a level, and is resticted from entering an area
        > WildBattleEncounter: anything to do with encountering a wild creature
        The rest are some scenes for the world
    }

Grass.tscn: is a redudant grass scene
GameIntro.tscn: is the game dialogue for the start of the game
