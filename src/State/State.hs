--State.State.hs




module State.State
(
	blankGame,
	updateWeather,
	updateLocation,
	updateUnit,
	updateInventory

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

updateWeather :: Enviro
updateWeather = (weather, location)
	where weather = getWeather

updateLocation :: Enviro
updateLocation = (weather, location)
	where location = getLocation

updateUnit :: Unit -> Units -> Units
updateUnit un (u:us) | un.getName == u.getName = u = newUnit
					 | otherwise = updateUnit un us
				where newUnit = createUnit u.getName u.getHP u.getAttack u.getDefense u.getSpeed u.IsPlayer 

--updateInventory :: Inv
--pdateInventory = 				

