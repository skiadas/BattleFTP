--State.State.hs




module State.State
(
	blankGame,

) where

import Unit.hs
import Environment.hs
import State.hs
import Inventory.hs

data Units = [Unit]
data Enviro = (Weather, Location)
data Inv = [Storage]

type State = (Units, Enviro, Inv)

blankGame :: State
blankGame = ([], (Clear, (0,0)), [[sword, shield, armour]])

