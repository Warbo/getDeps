module Paths_GetDebs (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/ouanixi/.cabal/bin"
libdir     = "/home/ouanixi/.cabal/lib/x86_64-linux-ghc-7.10.1/GetDebs-0.1.0.0-GkE8YeF2MVeFeXHCqZErAh"
datadir    = "/home/ouanixi/.cabal/share/x86_64-linux-ghc-7.10.1/GetDebs-0.1.0.0"
libexecdir = "/home/ouanixi/.cabal/libexec"
sysconfdir = "/home/ouanixi/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "GetDebs_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "GetDebs_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "GetDebs_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "GetDebs_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "GetDebs_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
