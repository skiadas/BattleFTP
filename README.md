# HanoverRPG

HanoverRPG is a text-based RPG game built in Haskell. The player will be able to create characters of various classes and races, and engage in combat with AI-generated opponents.

## Overall description

Here are some top-level modules that the project will need to contain.

- [Unit](#unit) manages all information related to playable as well as AI-generated units.
- [Equipment](#equipment) manages information related to equipment, weaponry and armor that one may carry.
- [Combat](#combat) manages the mechanics involved with hostile encounters, such as forming parties, managing actions and their order, managing in-combat unit health and buffs.
- [AI](#ai) is responsible for the management of enemy behavior.
- [UI](#ui) is responsible for user interaction, showing progress to the user and receiving input.
- [Game](#game) is responsible maintaining, storing and retrieving game information.
