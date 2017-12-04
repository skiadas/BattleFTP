{-# LANGUAGE DeriveGeneric #-}
{-|
Module      : State
Description : The State module
Copyright   : (c) Jonathan Helmers, 2017
                  Hannah Mundt, 2017
License     : MIT
Maintainer  : mundth19@hanover.edu

This module collects all data and returns it to game.
It will use organizational data types to maintain 
data from other groups.
Maintains, updates and stores data from environment,
unit, and inventory.


-}




module State
(
    blankGame,

) where

import Data.Aeson
--import Unit.hs
--import Environment.hs
--import Inventory.hs
--import State.State
import GHC.Generics

-- Module starts here.

data JSONUnit = JSONUnit {
    unit :: Unit (Username, Attributes, Death, IsPlayer)
 } deriving (Generic, Show)

data JSONEnvironment = JSONEnvironment {
    weather :: Weather 
    location :: Location     
 } deriving (Generic, Show)

data JSONInventory = JSONInventory {
    item :: Item 
 } deriving (Generic, Show) 

data JSONState = JSONState {
    units :: [JSONUnit]
    environment :: JSONEnvironment
    inventory :: JSONInventory
 } deriving (Generic, Show)


instance ToJSON JSONUnit where 
    toEncoding = genericToEncoding defaultOptions

instance FromJSON JSONUnit

instance ToJSON JSONEnvironment where
    toEncoding = genericToEncoding defaultOptions

instance FromJSON JSONEnvironment

instance ToJSON JSONInventory where
    toEncoding = genericToEncoding defaultOptions

instance FromJSON JSONInventory

instance ToJSON JSONState where
    toEncoding = genericToEncoding defaultOptions

instance FromJSON JSONState





