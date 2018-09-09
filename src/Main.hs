module Main where

import Control.Monad (unless)
import System.Environment (getArgs)
import System.Exit (exitSuccess)

import EnvStatus.Config (getAppConfig, showConfig)
import EnvStatus.Output.Types

main :: IO ()
main = do
  -- Args
  args <- getArgs
  validateArgs args
  let shell = (read . head $ args)::OutputFormat
  -- Config
  cp <- getAppConfig
  -- Output result
  putStrLn $ showConfig cp

validateArgs :: [String] -> IO ()
validateArgs args =
  unless (areArgsValid args) $ do
    printHelp
    exitSuccess

areArgsValid :: [String] -> Bool
areArgsValid args
  | null args = True
  | length args > 1 = False
  | head args == "--help" = False
  | otherwise = True

printHelp :: IO ()
printHelp = putStrLn $
  unlines [ ""
          , "envstatus [OPTIONS]"
          , ""
          , "envstatus extracts numerous information from the current execution environment and outputs it"
          , ""
          , "OPTIONS:"
          , "  --help            Displays this help"
          , ""
          , "  zsh               Outputs the environment details, using zsh PROMPT escape characters"
          , "  bash              Outputs the environment details, using bash PROMPT escape characters"
          , "  tmux              Outputs the environment details, using tmux PROMPT escape characters"
          , "  none              Outputs the environment details, using no escape characters (no color support)"
          ]
