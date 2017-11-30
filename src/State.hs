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

import Data.Aeson
--import Unit.hs
--import Environment.hs
--import Inventory.hs
import GHC.Generics


--module State
--(

--) where

-- Module starts here.

data JSONUnit = JSONUnit {
    username :: String--Username
    , hp :: Int--HP
    , attack :: Int--Attack
    , defense :: Int--Defense
    , speed :: Int --Speed
 } deriving (Generic, Show)

data JSONEnvironment = JSONEnvironment {
    map :: Map
    , block :: Block
    , building :: Building
    --weather??    
 } deriving (Generic, Show)

data JSONInventory = JSONInventory {
    item :: Item 
 } deriving (Generic, Show) 

data JSONState = JSONState {
    JSONUnit :: --
    JSONEnvironment :: --
    JSONInventory :: --
}

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