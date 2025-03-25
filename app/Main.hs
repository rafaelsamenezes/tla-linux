
module Main where

import PropertyLang
import System.Environment (getArgs)
import System.Exit (exitFailure)
import Text.Read(readMaybe)


main :: IO ()
main = do
  args <- getArgs
  case args of
    [] -> do
          putStrLn "Usage: ./tla-linux <property>"
          exitFailure
    arg:_ -> do
      
      let property = readMaybe arg :: Maybe Property
      case property of
        Nothing -> do
          putStrLn "Invalid property"
          exitFailure
        Just p -> do
          putStrLn "Property ok..."
          putStrLn "==== TOP OF PCI ============"
          putStrLn code_pre 
          putStrLn $ generatePropertyFunction p
          putStrLn "==== END TOP OF PCI ============"
          putStrLn "==== CHANGES TO PCI_BUS_ADD_DEVICE ============"
          putStrLn generatePciAddDevice
          putStrLn "==== END OF CHANGES OF PCI_BUS_ADD_DEVICE ============"
  putStrLn "Finished!"
