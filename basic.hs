#!/usr/bin/env stack
-- stack script --resolver lts-8.8 --package conduit-combinators
import Conduit

main = do
  -- Pure operations: summing numbers.
  print $ runConduitPure $ yieldMany [1..10] .| sumC

  -- Exception safe file access: copy a file.
  writeFile "input.txt" "This is a test." -- create the source file
  runConduitRes $ sourceFileBS "input.txt" .| sinkFile "output.txt" -- actual copying
  readFile "output.txt" >>= putStrLn -- prove that it worked

  -- Perform transformations.
  print $ runConduitPure $ yieldMany [1..10] .| mapC (+ 1) .| sinkList