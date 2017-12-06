
{-Module      : Unit
Description : The Unit module
Copyright   : (c) Collin Umphrey, 2017
                  Graham Wood, 2017
License     : Hanover College
Maintainer  : umphreyc19@hanover.edu

Here is a longer description of this module, containing some
commentary with @some markup@. 

Basic and advanced parts of units, including but not limited to:
Stats - HP, Attack, Defense, Speed, Intelligence(power of magic and defense of magic(maybe if we do magic))
Levels - Stat growths through levels, what level would be max, current level and experience.
Abilities - 
Classes - What each class can do

Attributes



-}



module Unit
(
 Unit,
 createUnit,
 changeHealth,
 changeAttack,
 changeDefense,
 changeSpeed,
 getName,
 getHealth,
 getMaxHP,
 getAttack,
 getDefense,
 getSpeed

) where

import Inventory 

type Username = String
type HP = Int
type MaxHP = Int
type Attack = Int --A stat that influences damage done in battle
type Defense = Int --A stat that influences how much damage is taken in battle
type Speed = Int --A stat that influences avoid chance and turn order
data Attributes = Attributes (HP,MaxHP,Attack,Defense,Speed)
data Unit = Unit (Username, Attributes,Equipment, Death, IsPlayer) --The collection of important stats
type Death = Bool --Is a unit dead or not. Defaults to alive
type IsPlayer = Bool  --Is it a player or not. Defaults to Enemy
data Equipment = Equipment(Unit, HasSword, HasShield, HasArmor, Storage)
type HasSword = Maybe Weapon
type HasShield = Maybe Shield
type HasArmor = Maybe Armour

-- Module starts here.

--Given a unit returns that unit's name
getName :: Unit -> String
getName (Unit (pName, _, _, _)) = pName

--given a unit's attributes, returns its HP
getHealth :: Unit -> Int
getHealth (Unit (_, Attributes(hp, _, _, _, _) ,_ ,_)) = hp

getMaxHP :: Unit -> Int
getMaxHP (Unit (_, Attributes(_, maxHP, _, _, _) ,_ ,_)) = maxHP
--given a unit's attributes, returns its Attack
getAttack :: Unit -> Int
getAttack (Unit (_, Attributes(_, _, atk, _, _) ,_ ,_)) = atk

--given a unit's attributes, returns its Defense
getDefense :: Unit -> Int
getDefense (Unit (_, Attributes(_, _, _, def, _) ,_ ,_)) = def

--given a unit's attributes, returns its Speed
getSpeed :: Unit -> Int 
getSpeed (Unit (_, Attributes(_, _, _, _, spd) ,_ ,_)) = spd



createUnit :: Username -> HP -> Attack -> Defense -> Speed -> IsPlayer -> Unit
createUnit unitName maxHP atk def spd player = (Unit (unitName, (Attributes (maxHP, maxHP, atk, def, spd)), False, player))

--given a set of attributes, and a new HP stat, returns those attributes with the updated stat
changeHealth :: Unit -> Int -> Unit
changeHealth (Unit (name, (Attributes (oldHP, maxHP, atk, def, spd)), death, player)) newHP = (Unit (name, Attributes (newHP, maxHP, atk, def, spd), death, player))

--given a set of attributes, and a new Attack, returns those attributes with the updated stat
changeAttack :: Unit -> Int -> Unit
changeAttack (Unit ( name, (Attributes (hp,maxHP, oldAtk, def, spd)), death, player)) newAtk = (Unit ( name, Attributes (hp,maxHP, newAtk, def, spd), death, player))

--given a set of attributes, and a new Defense, returns those attributes with the updated stat
changeDefense :: Unit -> Int -> Unit
changeDefense (Unit ( name, (Attributes (hp,maxHP, atk, oldDef, spd)), death, player)) newDef = (Unit ( name, Attributes (hp,maxHP, atk, newDef, spd), death, player))

--given a set of attributes, and a new Speed, returns those attributes with the updated stat
changeSpeed :: Unit -> Int -> Unit
changeSpeed (Unit (name, (Attributes (hp,maxHP, atk, def, oldSpd)), death, player)) newSpd = (Unit (name, Attributes (hp,maxHP, atk, def, newSpd), death, player))










