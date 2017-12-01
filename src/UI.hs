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
-- module UI
-- (

-- ) where

-- Module starts here.
import Prelude hiding (Either(..))
import System.Console.ANSI
import System.IO
import Data.Char

data Command = Empty
            |Move
            |I
            |Use
            |Pickup
            |Exit

data SubCommand = Void
                |F
                |B
                |L
                |R
                |Show
                |Heal


stringToCom :: String -> Command
stringToCom "move" = Move
stringToCom "i" = I
stringToCom "use" = Use
stringToCom "pickup" = Pickup
stringToCom "exit" = Exit
stringToCom _ = Empty

stringToSubCom :: String -> SubCommand
stringToSubCom "f" = F
stringToSubCom "b" = B
stringToSubCom "l" = L
stringToSubCom "r" = R
stringToSubCom "show" = Show
stringToSubCom "food" = Heal --food?
stringToSubCom _ = Void

readCom :: [String] -> (Command, SubCommand)
readCom s = (s', s'')
    where   s' = stringToCom (head s)
            s'' = if length s == 2 then stringToSubCom (s !! 1) else stringToSubCom ""

--Method to change user input to commands
processCommand :: String -> (Command, SubCommand)
processCommand s = readCom (words (map toLower s))

--Method to execute commands
executeCommand :: (Command, SubCommand) -> IO()
executeCommand (Move, F) = drawScreen
executeCommand (Move, B) = drawScreen
executeCommand (Move, L) = drawScreen
executeCommand (Move, R) = drawScreen
executeCommand (I, Show) = drawScreen
executeCommand (Use, Heal) = drawScreen
executeCommand (Pickup, Void) = drawScreen
executeCommand (Exit, Void) = handleExit
executeCommand (_, _) = printWarning

--caluculate bar width max 50 --int or string?
calculateStat :: Int -> String
calculateStat stat = replicate (stat `div` 10) '█'

--test data
health::Int 
health = 100
dex::Int 
dex = 50
stamina::Int 
stamina = 50
combat::Bool
combat = True

--Method to draw all information to the screen...
--Where all the UI magics will be made 😁
drawScreen :: IO()
drawScreen = do
    clearScreen
    drawStat ("Health", health, 0,0)
    drawStat ("Dexterity", dex, 1,0)
    drawStat ("stamina", stamina, 2,0)
    if combat then drawStat ("Enemy Health", health, 0,40) else return ()
    if combat then drawStat ("Enemy Dexterity", dex, 1,40) else return ()
    if combat then drawStat ("Enemy stamina", stamina, 2,40) else return ()
    --drawString (replicate 50 '*' 3,0)
    drawString ("Progress: 75" ++ calculateStat 50, 4,0)
    drawString ("Part 1: ", 5,5)
    drawString ("Part 2: ", 6,5)
    drawString ("Part 3: ", 7,5)
    --drawString (replicate 50 '*' 8,0)
    drawString ("Past Events: ", 10,0)

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
    --hSetEcho stdin False --how do we accept input?
    --hSetBuffering stdin  NoBuffering --sounds like we want buffering
    --hSetBuffering stdout NoBuffering --sounds like we want buffering
    --hideCursor
    setSGR [ SetConsoleIntensity BoldIntensity
            , SetColor Foreground Vivid Blue
            , SetColor Background Dull Black ]
    drawScreen
    gameLoop False
    

-- update the game loop to add in the goodbye message
gameLoop :: Bool -> IO()
gameLoop warning = do
    putStrLn "\n"
    if not warning then putStrLn "Enter The Command, Sir: " else putStrLn "YOU MUST ENTER A VALID COMMAND!!! 😂😂😂"
    commands <- getLine
    let comTuple = processCommand commands

    executeCommand comTuple
    case comTuple of
        (Exit, Void) -> handleExit
        _    -> gameLoop False


printWarning :: IO()
printWarning = gameLoop True
    

  -- when the user wants to exit we give them a thank you
  -- message and reset the terminal
handleExit :: IO()
handleExit = do
    setSGR [Reset]
    clearScreen
    setCursorPosition 0 0
    showCursor
    putStrLn "Thank you for playing!!!"
    --putStrLn "\xF0\x9F\x98\x82" 
    putStrLn "😂😂😂"