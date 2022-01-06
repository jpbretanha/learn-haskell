{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_quickcheck (
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

bindir     = "/Users/joaopedrobretanha/workspace/aula-haskell-ufabc/quickcheck/.stack-work/install/x86_64-osx/9086883ea2fd5928154f01dd82bd3f0f56fe04a02a412d0d926ff18e8bf333ed/8.10.7/bin"
libdir     = "/Users/joaopedrobretanha/workspace/aula-haskell-ufabc/quickcheck/.stack-work/install/x86_64-osx/9086883ea2fd5928154f01dd82bd3f0f56fe04a02a412d0d926ff18e8bf333ed/8.10.7/lib/x86_64-osx-ghc-8.10.7/quickcheck-0.1.0.0-5rSDtHj6HftGaxeoYQTTyj-quickcheck"
dynlibdir  = "/Users/joaopedrobretanha/workspace/aula-haskell-ufabc/quickcheck/.stack-work/install/x86_64-osx/9086883ea2fd5928154f01dd82bd3f0f56fe04a02a412d0d926ff18e8bf333ed/8.10.7/lib/x86_64-osx-ghc-8.10.7"
datadir    = "/Users/joaopedrobretanha/workspace/aula-haskell-ufabc/quickcheck/.stack-work/install/x86_64-osx/9086883ea2fd5928154f01dd82bd3f0f56fe04a02a412d0d926ff18e8bf333ed/8.10.7/share/x86_64-osx-ghc-8.10.7/quickcheck-0.1.0.0"
libexecdir = "/Users/joaopedrobretanha/workspace/aula-haskell-ufabc/quickcheck/.stack-work/install/x86_64-osx/9086883ea2fd5928154f01dd82bd3f0f56fe04a02a412d0d926ff18e8bf333ed/8.10.7/libexec/x86_64-osx-ghc-8.10.7/quickcheck-0.1.0.0"
sysconfdir = "/Users/joaopedrobretanha/workspace/aula-haskell-ufabc/quickcheck/.stack-work/install/x86_64-osx/9086883ea2fd5928154f01dd82bd3f0f56fe04a02a412d0d926ff18e8bf333ed/8.10.7/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "quickcheck_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "quickcheck_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "quickcheck_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "quickcheck_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "quickcheck_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "quickcheck_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
