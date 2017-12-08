{-|
Module      : AI
Description : The AI module
Copyright   : (c) Brian Hayes,
                  Tyler Walker, 2017
License     : MIT
Maintainer  : walkert20@hanover.edu

Here is a longer description of this module, containing some
commentary:
    This module is for the brains of all AI units within 
    the game, providing all AI units with actions and strategies
    for combating the UI units. This module is mostly internal. 

    findLowstHp is a function that returns 
    the AI unit with the least health within a given 
    list of either Ai or Ui units.

    lessThan50PercentHp is a function that 
    looks for a unit whose health is less 
    than half of its max health out of the 
    given list of Ai or Ui units.

    choseAction is a function that returns 
    an Action for the turn AI unit to perform. 
-}
module AI
(
    -- some functions
    chooseAction
) where

-- Module starts here.

import System.Random
import Combat.ActionOptions
import Unit

-- A function that returns the AI unit with the least health.
-- [Unit] can either be the Ai units or the player units.
findLowestHp:: [Unit] -> Unit
findLowestHp (x:[])                  = x
findLowestHp (x,y:rest) 
        |getHealth x < getHealth y   = findLowestHp (x:rest)
        |getHealth x == getHealth y  = findLowestHp (x:rest)
        |otherwise                   = findLowestHp (y:rest)

-- A function that looks for a unit whose hp<=50%
-- [Unit] can either be the Ai units or the player units.
lessThan50PercentHp:: [Unit] -> Bool
lessThan50PercentHp []      = False
lessThan50PercentHp (x:xs)
    |getHealth x <= half    = True
    |otherwise              = lessThan50PercentHp (xs)
        where half = (getMaxHP x)/2

-- A function that returns an Action for the AI to perform. 
-- Unit is the current Ai whose turn it is.
-- 1st [Unit] is the Ai units, including the turn Ai. This is basically
--   the turn Ai and its allies if there are any.
-- 2nd [Unit] is the Ui/player units.
chooseAction:: (Unit,Unit)-> IO Action
chooseAction ai player = do
        x <- rollDice
        if lessThan50PercentHp [ai] && rollDice <= 35
            then return  Heal (ai, ai)
            else return  Attack (ai, player) 

-- A helper function for chooseAction.
-- returns a random number betwee 1 and 100. 
rollDice :: IO Int
rollDice = getStdRandom (randomR (1,100))