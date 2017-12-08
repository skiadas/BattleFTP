{-|
Module      : Environment
Description : The Environment module
Copyright   : (c) Gage Hafl, 2017
                  Terriyon Veasy, 2017
License     : MIT
Maintainer  : haflg19@hanover.edu
              veasyt19@hanover.edu

The Environment module tracks the current Location of the player and provides the functionality to control this. The players Location is defined by @data Location@. This can be tracked and modified with several methods: @path@, @getLocationindex@, @getLocation@, @nextLocation@.
-}
import Data.List

-- module Environment
-- (
--  -- public datas and types
--  Location,

--  -- public functions
--  path,
--  getLocation,
--  getLocationIndex,
--  nextLocation
-- ) where

-- Module starts here

data Location = Scenic | Library | CC | Parker | Point deriving (Eq, Show)
type Spot = (Location, Int)


path :: [Location]
path = [Scenic, Library, CC, Parker, Point]

spotFromInd :: Int -> Spot
spotFromInd a = (Scenic, 0)

spotFromName :: Location -> Spot
spotFromName a = (Scenic, 0)

getLocationName :: Int -> Location
getLocationName a = Scenic

getLocationIndex :: Location -> Int
getLocationIndex a = 0

nextLocation :: Spot -> Spot
nextLocation a = (Scenic, 0)