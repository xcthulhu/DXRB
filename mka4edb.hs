module Main where
import System.IO
import Data.List.Split (splitOn, splitPlaces)
import Data.List (isPrefixOf,drop,intercalate)
import System.Environment (getArgs,getProgName)                               

(|>) :: a -> (a -> b) -> b
x |> f = f x

-- Counts per second of the Crab Nebula
crab :: Float
crab = read "2.658e+01"

mktime :: Integer -> String -> String
mktime offset str = intercalate ":" $ splitPlaces [offset + 2,2,5] str

process str = intercalate "\n" $
              do { ln <- lines str
                 ; let ln' = splitOn "|" $ filter (/=' ') ln
                 ; return $ 
                   ln' !! 1 ++ ",f|S," 
                   ++ (mktime 0 $ ln' !! 2) ++ "," 
                   ++ (mktime 1 $ ln' !! 3) ++ ","
                   ++ (show $ (read $ ln' !! 4) / crab) }

getFile :: String -> IO String
getFile fn = do fh <- openFile fn ReadMode
                ctnts <- hGetContents fh 
                -- hClose fh
                return ctnts

main = do argv <- getArgs
          name <- getProgName
          if not (null argv)
             then putStrLn =<< (fmap process $ getFile (argv !! 0))
             else hPutStrLn stderr $ "usage: " ++ name ++ " <file>"