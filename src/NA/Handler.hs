module NA.Handlers

import Servant

import NA.Types

getPolicy :: T.Text -> Handler Policy
getPolicy policyName = do
  dataDir <> policyName

dataDir :: FilePath
dataDir = "./data/"
