--State.State.hs




module State.State
(
	blankGame,
	updateEnvironment,
	unitHelper,
	updateUnit,
	updateInventory,

) where

import Unit.hs
import Environment.hs
import State.hs
import Inventory.hs

data Units = [Unit]
data Enviro = (Weather, Location)
data Inv = [Equipment]

type State = (Units, Enviro, Inv)

-- creat a blank game to start
blankGame :: State
blankGame = ([], (Clear, (0,0)), [])

-- get units from current state
getUnits :: State -> Units
getUnits (u, _, _) = u

-- get environment from current state
getEnviro :: State -> Enviro
getEnviro (_, e, _) = e

-- get inventory from current state
getInv :: State -> Inv
getInv (_, _, i) = i

-- update environment
updateEnvironment :: Enviro -> State -> State
updateWeather (weather, location) (u, e, i) = (getUnits u e i, (weather, location), getInv u e i)

-- updates the current unit to the new unit
-- used in updateUnit function
unitHelper :: Unit -> Units -> Units
unitHelper un (u:us) | un.getName == u.getName = u = un 
					 | otherwise = updateUnit un us

-- update unit
updateUnit :: Unit -> State -> State
updateUnit u (u, e, i) = (unitHelper u, getEnviro u e i, getInv u e i) 

-- updates the current inventory to the new inventory
-- used in updateInv function			
inventoryHelper :: Units -> Inv 
inventoryHelper (u:us) = 

-- update inventory
updateInventory :: Inv -> State -> State
updateInventory (e:es) (u, e, i) = (getUnits u e i, getEnviro u e i, ) 

--
addUnit :: Unit -> State -> State
addUnit u (u, e, i) = (u:getUnits u e i, getEnviro u e i, getInv u e i)


