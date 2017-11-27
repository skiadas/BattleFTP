{-|
Module      : UI
Description : The UI module
Copyright   : (c) Alexander Martens, 2017
                  Patrick Conboy, 2017
License     : MIT ( (BSD-3) )
Maintainer  : support@hanover.edu


The UI module communicates with the user by writing fancy ANSI graphics to 
the terminal and accepting user input in the form of text. The UI module is 
reponsible for all interaction with the user. The UI module shall call other
modules in accordance with the terms. No other module shall interfere with user
input and no other module may ping the UI module to do anything. The user is the
only one the application servers. (((Google)))
Random events for any reason will be triggered by the UI and the UI will always supply
sufficient information to for the rest of the application. 
-}
module UI
(

) where

-- Module starts here.
