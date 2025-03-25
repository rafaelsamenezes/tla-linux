{- TLA+ Grammar parser-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}
import Control.Applicative
import Control.Monad
import Data.Text (Text)
import Data.Void
import Text.Megaparsec hiding (State)
import Text.Megaparsec.Char
import qualified Data.Text as T
import qualified Text.Megaparsec.Char.Lexer as L



-------------
-- GRAMMAR --
-------------

data PrefixOp = PrefixMinus | BitwiseNot | Not | Negation | 

------------
-- PARSER --
------------
type Parser = Parsec Void Text
