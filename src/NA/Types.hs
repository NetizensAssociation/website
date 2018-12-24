{-# LANGUAGE TemplateHaskell #-}
module NA.Types where

import Data.Aeson
import qualified Data.Text as T
import Control.Lens
import GHC.Generics (Generic)
import GHC.Exts (IsString(..))

data Policy = Policy
  { _name :: T.Text
  , _website :: T.Text
  , _rules :: [Rule]
  } deriving (Eq, Show, Generic)

instance ToJSON Policy where toEncoding = genericToEncoding customOpts
instance FromJSON Policy where parseJSON = genericParseJSON customOpts

data Rule = Rule
  { _sites :: [T.Text]
  , _actions :: [Action]
  } deriving (Eq, Show, Read, Generic)

instance ToJSON Rule where toEncoding = genericToEncoding customOpts
instance FromJSON Rule where parseJSON = genericParseJSON customOpts

data Action = Action
  { _action :: ActionType
  , _reason :: Reason
  } deriving (Eq, Show, Read, Generic)

instance ToJSON Action where toEncoding = genericToEncoding customOpts
instance FromJSON Action where parseJSON = genericParseJSON customOpts

data ActionType
  = Block
  | Warn
  | Protest
  deriving (Eq, Show, Read, Generic, Enum, Bounded)

instance FromJSON ActionType where
  parseJSON = withText "ActionType" $ \s -> case s of
    "block" -> pure Block
    "warn" -> pure Warn
    "protest" -> pure Protest
    _ -> fail "Expecting one of 'block', 'warn', or 'mismatch'"

instance ToJSON ActionType where
  toJSON x = case x of
    Block -> "block"
    Warn -> "warn"
    Protest -> "protest"

newtype Reason = Reason { getReason :: T.Text }
  deriving (Eq, Show, Read, Generic, IsString, FromJSON, ToJSON)

customOpts :: Options
customOpts = defaultOptions { fieldLabelModifier = drop 1 }

makeLenses ''Policy
makeLenses ''Rule
makeLenses ''Action
makeLenses ''ActionType
makeLenses ''Reason
