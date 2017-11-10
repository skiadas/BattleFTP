# BattleFTP

BattleFTP (Battle for the Point) is a text-based RPG game built in Haskell. The player will be able to create characters of various classes and races, and engage in combat with AI-generated opponents.

## Overall description

Here are some top-level modules that the project will need to contain.


- [Game](#game) (suggested) is the overall game module that manages the others. It will be the one producing the main executable.
    - Need some world traversal mechanics, an end goal.
- [Unit](#unit) manages all information related to playable as well as AI-generated units.
    - Possible actions: Attack, Defend, Flee, Wait, what else?
    - Should there be separate modules for AI and UI units? Or should they be submodules of the unit module?
- [Equipment](#equipment) manages information related to equipment, weaponry and armor that one may carry.
    - Have standard "template" of equipment for the user to pick from?
- [Combat](#combat) manages the mechanics involved with hostile encounters, such as forming parties, managing actions and their order, managing in-combat unit health and buffs.
    - List of possible actions determined by user attributes, health, location, equipment, enemy type.
    - How do we handle "deaths"?
- [Event](#event) manages the different events in the game. Is this needed? How does it interact with Combat? Is a whole combat one event? What other events might we have?
- [AI](#ai) is responsible for the management of enemy behavior.
    - Maybe rename to AILogic?
    - Will need to determine actions based on "enemy" attributes.
    - Will be nice to have difficulty levels.
- [UI](#ui) is responsible for user interaction, showing progress to the user and receiving input.
- [State](#state) is responsible maintaining, storing and retrieving the game state.
- [Environment](#environment) (suggested) manages the different environments in the game world.
