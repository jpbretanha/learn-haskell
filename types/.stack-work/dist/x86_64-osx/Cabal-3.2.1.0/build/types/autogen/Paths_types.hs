{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_types (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/joaopedrobretanha/workspace/aula-haskell-ufabc/types/.stack-work/install/x86_64-osx/e62968ef54e56faa28f8c2fc84fd956c81513cf4c976059277da4e737cc61e69/8.10.7/bin"
libdir     = "/Users/joaopedrobretanha/workspace/aula-haskell-ufabc/types/.stack-work/install/x86_64-osx/e62968ef54e56faa28f8c2fc84fd956c81513cf4c976059277da4e737cc61e69/8.10.7/lib/x86_64-osx-ghc-8.10.7/types-0.1.0.0-4IpMA0BF2fT9aKIxzUgDAd-types"
dynlibdir  = "/Users/joaopedrobretanha/workspace/aula-haskell-ufabc/types/.stack-work/install/x86_64-osx/e62968ef54e56faa28f8c2fc84fd956c81513cf4c976059277da4e737cc61e69/8.10.7/lib/x86_64-osx-ghc-8.10.7"
datadir    = "/Users/joaopedrobretanha/workspace/aula-haskell-ufabc/types/.stack-work/install/x86_64-osx/e62968ef54e56faa28f8c2fc84fd956c81513cf4c976059277da4e737cc61e69/8.10.7/share/x86_64-osx-ghc-8.10.7/types-0.1.0.0"
libexecdir = "/Users/joaopedrobretanha/workspace/aula-haskell-ufabc/types/.stack-work/install/x86_64-osx/e62968ef54e56faa28f8c2fc84fd956c81513cf4c976059277da4e737cc61e69/8.10.7/libexec/x86_64-osx-ghc-8.10.7/types-0.1.0.0"
sysconfdir = "/Users/joaopedrobretanha/workspace/aula-haskell-ufabc/types/.stack-work/install/x86_64-osx/e62968ef54e56faa28f8c2fc84fd956c81513cf4c976059277da4e737cc61e69/8.10.7/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "types_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "types_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "types_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "types_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "types_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "types_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
