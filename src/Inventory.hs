{-|
Module      : Inventory
Description : The Inventory module
Copyright   : (c) Jacob Hedrick, 2017
                  Chris Roe, 2017
License     : MIT
Maintainer  : sample@email.com

Here is a longer description of this module, containing some
commentary:
	This module creates and controls all items in the game. It will be used to create
	different classes of items (weapons, shields, armor, etc.), the different items
	in each class, and assign attrbutes to each of these items. We will also create and
	maintain the UI storage of items. This module is mainly opaque with many methods to 
	be used by other teams.

-}
module Inventory
(
    Storage, -- exporting the storage type
    Item, -- exporting the item type
    storage, -- constructor for making a starting Storage
    numItems, -- returns the number of items in a storage object
    insertItem, -- inserts a new item into a storage object
    listStorage, -- list the Items in Storage by their names
    removeItem, -- removes the first occurance of a given Item in Storage
    getItem, --returns the attributes of a given Item
    sword, -- basic starting weapon of type Item
    shield, -- basic starting shield of type Item
    armour, -- basic starting armour of type Item
    goldSword, --weapon made of gold

) where
-- Module starts here.
-- Definition for the Storage data type
-- A list of items in the units possession
data Storage = Stor [Item] 
-- Definition for the Item data type
-- An Item is a 6-tuple with values: (name, ItemType, HP, Attack, Defense, Speed)
type Item = (String, ItemType, Int, Int, Int, Int)
--Definition for the ItemType data type
--Has 3 values (Weapon, Shield, Armour) to describe what type an item is
data ItemType = Weapon|Shield|Armour

--Pre-made items
sword = ("sword", Weapon, 0, 2, 1, 0) :: Item
shield = ("shield", Shield, 0, 1, 3, -1) :: Item
armour = ("armour", Armour, 3, 0, 0, -2) :: Item


-- Create the starting inventory with basic sword, sheild, and armor
storage:: Storage
storage = Stor [sword, shield, armour]

-- Returns the number of items in the unit storage
numItems:: Storage -> Int
numItems (Stor []) = 0
numItems (Stor (x:xs)) = 1 + numItems (Stor (xs))

-- Inserts a new item into the storage list
-- Does nothing and returns a warning message if storage is full
insertItem:: Item -> Storage -> Storage
insertItem i (Stor stor1) = Stor newStorage
    where newStorage = stor1 ++ [i]

-- Returns a list of the names of the Items in your Storage
listStorage:: Storage -> [String]
listStorage (Stor []) = []
listStorage (Stor ((name, _, _, _, _, _): xs)) = name : listStorage (Stor (xs))

-- Returns the name of a given item
getName:: Item -> String
getName (name, _, _, _, _, _) = name

-- Returns the type of a given item
getType:: Item -> ItemType
getType (_, iType, _, _, _, _) = iType

-- Returns the type of a given item
getHPEff:: Item -> Int
getHPEff (_, _, hp, _, _, _) = hp

-- Returns the type of a given item
getAttackEff:: Item -> Int
getAttackEff (_, _, _, attack, _, _) = attack

-- Returns the type of a given item
getDefEff:: Item -> Int
getDefEff (_, _, _, _, defense, _) = defense

-- Returns the type of a given item
getSpeedEff:: Item -> Int
getSpeedEff (_, _, _, _, _, speed) = speed


-- Seaches for an item in the Storage and removes it if it is found
removeItem:: Item -> Storage -> Storage
removeItem _ (Stor []) = (Stor [])
removeItem i (Stor (x:xs)) | (getName x) == (getName i) = (Stor (xs))
                           | otherwise = insertItem x (removeItem i (Stor (xs)))

-- Returns the attribute of a given Item
getItem::Item -> Item
getAttributes i = i