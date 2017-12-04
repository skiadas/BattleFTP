{-|
Module      : UI
Description : The UI module
Copyright   : (c) Alexander Martens, 2017
                  Patrick Conboy, 2017
License     : MIT ( (BSD-3) )
Maintainer  : conboyp19@hanover.edu

The UI module communicates with the user by writing fancy ANSI graphics to 
the terminal and accepting user input in the form of text. The UI module is 
reponsible for all interaction with the user. The UI module shall call other
modules in accordance with the terms. No other module shall interfere with user
input, and no other module may ping the UI module to do anything. The user is the
only one the application serves. (((Google)))
Random events for any reason will be triggered by the UI and the UI will always supply
sufficient information for the rest of the application.
-}
-- (

-- ) where

-- Module starts here.
import Prelude hiding (Either(..))
import System.Console.ANSI
import System.IO
import Data.Char
import Control.Monad

data Command = Empty
            |Move
            |I
            |Equip
            |Use
            |Pickup
            |Exit
            |Attack

data SubCommand = Void
                |F
                |B
                |L
                |R
                |Show
                |Heal
                |Sword
                |Weapon
                |Armour


stringToCom :: String -> Command
stringToCom "move" = Move
stringToCom "i" = I
stringToCom "use" = Use
stringToCom "pickup" = Pickup
stringToCom "exit" = Exit
stringToCom "equip" = Equip
stringToCom "" = Attack
stringToCom _ = Empty

stringToSubCom :: String -> SubCommand
stringToSubCom "f" = F
stringToSubCom "b" = B
stringToSubCom "l" = L
stringToSubCom "r" = R
stringToSubCom "show" = Show
stringToSubCom "food" = Heal --food?
stringToSubCom "sword" = Sword
stringToSubCom "weapon" = Weapon
stringToSubCom "armor" = Armour
stringToSubCom _ = Void

readCom :: [String] -> (Command, SubCommand)
readCom s = (s', s'')
    where   s' = if not (null s) then stringToCom (head s) else stringToCom ""
            s'' = if length s == 2 then stringToSubCom (s !! 1) else stringToSubCom ""

--Method to change user input to commands
processCommand :: String -> (Command, SubCommand)
processCommand s = readCom (words (map toLower s))

--Method to execute commands
executeCommand :: (Command, SubCommand) -> IO()
executeCommand (Move, F) = moveF
executeCommand (Move, B) = moveB
executeCommand (Move, L) = moveL
executeCommand (Move, R) = moveR
executeCommand (I, Show) = drawScreen -- keep this command or?
executeCommand (Use, Heal) = healMe
executeCommand (Pickup, Void) = pickupThis
executeCommand (Exit, Void) = handleExit
executeCommand (Attack, _) = attack
executeCommand (Equip, a) = equip a
executeCommand (_, _) = printWarning

--commands-- TODO:hook these up
moveF :: IO()
moveF = drawString ("Slot 10: RED",13,20)
moveB :: IO()
moveB = drawString ("Slot 10: RED",13,20)
moveL :: IO()
moveL = drawString ("Slot 10: RED",13,20)
moveR :: IO()
moveR = drawString ("Slot 10: RED",13,20)
healMe :: IO()
healMe = drawString ("Slot 10: RED",13,20)
pickupThis :: IO()
pickupThis = drawString ("Slot 10: RED",13,20)
attack :: IO()
attack = drawString ("Slot 10: RED",13,20)

--Equip the best sword, weapon, etc
equip :: SubCommand -> IO()
equip item = drawString ("Slot 10: RED",13,20)

--caluculate bar width max 50 --int or string?
calculateStat :: Int -> String
calculateStat stat = replicate (stat `div` 2) '█'

--test data TODO: replace with real state
health::Int 
health = 100
dex::Int 
dex = 50
stamina::Int 
stamina = 50
progress::Int 
progress = 75
combat::Bool
combat = True
event1::String
event1 = "old mcdonald died"
event2::String
event2 = "I got more food"
event3::String
event3 = "healed for 10 bucks"
event4::String
event4 = ""

--Method to draw all information to the screen...
--Where all the UI magics will be made 😁
drawScreen ::IO()
drawScreen = do
    clearScreen
    drawStat ("Health", health, 0,0)
    drawStat ("Dexterity", dex, 1,0)
    drawStat ("Stamina", stamina, 2,0)
    when combat $ drawStat ("Enemy Health", health, 0, 40)
    when combat $ drawStat ("Enemy Dexterity", dex, 1, 40)
    when combat $ drawStat ("Enemy Stamina", stamina, 2, 40)

    drawString (replicate 80 '*', 4, 0)
    drawString ("Progress: " ++ show progress ++ " " ++ calculateStat progress, 5,0)
    drawString ("Part 1: ", 6,0)
    drawString ("Part 2: ", 6,20)
    drawString ("Part 3: ", 6,40)
    
    drawString ("Inventory: ", 8,0)

    drawString ("Slot 1: ", 9,0)
    drawString ("Slot 2: ", 10,0)
    drawString ("Slot 3: ", 11,0)
    drawString ("Slot 4: ", 12,0)
    drawString ("Slot 5: ", 13,0)

    drawString ("Slot 6: ", 9,20)
    drawString ("Slot 7: ", 10,20)
    drawString ("Slot 8: ", 11,20)
    drawString ("Slot 9: ", 12,20)
    drawString ("Slot 10: ",13,20)

    drawString ("Slot 11: ", 9,40)
    drawString ("Slot 12: ", 10,40)
    drawString ("Slot 13: ", 11,40)
    drawString ("Slot 14: ", 12,40)
    drawString ("Slot 15: ", 13,40)

    drawString ("Slot 16: ", 9,60)
    drawString ("Slot 17: ", 10,60)
    drawString ("Slot 18: ", 11,60)
    drawString ("Slot 19: ", 12,60)
    drawString ("Slot 20: ", 13,60)
    
    drawString (replicate 80 '*', 14, 0)
    drawString ("Past Events: ", 15,0)
    unless (null event1) $ drawString (event1, 16, 5)
    unless (null event2) $ drawString (event2, 17, 5)
    unless (null event3) $ drawString (event3, 18, 5)
    unless (null event4) $ drawString (event4, 19, 5)
    
drawStat :: (String, Int, Int, Int) -> IO()
drawStat (statName, stat, x, y) = do
        drawString (statString, x,y)
        -- drawString (statBar, x,statLength)
                where   statString = statName ++ ": " ++ show stat
        --                 statStringLength = length statString
        --                 whitespace = replicate (statStringLength - 15) '.'
        --                 statLength = length whitespace + statStringLength
        --                 statBar = " " ++ calculateStat stat

--Method to draw a string at a certain position on the screen
--Params: string: string to draw
--Params: x: where to draw 
--Params: y: where to draw
drawString :: (String, Int, Int) -> IO()
drawString (string, x, y) = do
    setCursorPosition x y
    putStr string

main :: IO()
main = do 
    setTitle "Battle! For The Point"
    setSGR [ SetConsoleIntensity BoldIntensity
            , SetColor Foreground Dull Red
            , SetColor Background Dull Black ]
    drawScreen
    normalGameLoop
    

-- update the game loop to add in the goodbye message
gameLoop :: Bool -> IO()
gameLoop warning = do
    drawScreen
    putStrLn "\n"
    if not warning then putStrLn "Enter The Command: " else putStrLn "YOU MUST ENTER A VALID COMMAND: "
    commands <- getLine
    let comTuple = processCommand commands

    executeCommand comTuple
    case comTuple of
        (Exit, Void) -> handleExit
        _    -> normalGameLoop


printWarning :: IO()
printWarning = gameLoop True
    
normalGameLoop :: IO()
normalGameLoop = gameLoop False

  -- reset the SGR and give a thank you message/¿massage?
handleExit :: IO()
handleExit = do
    setSGR [Reset]
    clearScreen
    setCursorPosition 0 0
    showCursor
    putStrLn "Thanks for playing!!! 😂😂😂"