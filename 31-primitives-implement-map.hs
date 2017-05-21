#!/usr/bin/env stack
-- stack script --resolver lts-8.12 --package conduit-combinators

{-# LANGUAGE ExtendedDefaultRules #-}

import Conduit

myMapC :: Monad m => (i -> o) -> ConduitM i o m ()
myMapC f = loop
  where
    loop = do
      mx <- await
      case mx of
        Nothing -> return ()
        Just x -> do
          yield (f x)
          loop

main :: IO ()
main = runConduit $ yieldMany [1..10] .| myMapC (+ 1) .| mapM_C print
