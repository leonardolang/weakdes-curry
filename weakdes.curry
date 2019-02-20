-- This code was tested on the Munster Curry Compiler
--
-- PACKS or KICS will require changing "findall" for some other
-- library function, like "Findall.allSolutions".

type B = Bool

type Nibble  = (B, B, B, B)
type Byte    = (B, B, B, B, B, B, B, B)

type Key     = (Byte, Byte, Byte, Byte, Byte, Byte, Byte)
type SubKey  = (Byte, Byte, Byte, Byte, Byte, Byte)
type HalfKey = (Nibble, Nibble, Nibble, Nibble, Nibble, Nibble, Nibble)


pc1 :: Key -> Key
pc1 ((b01, b02, b03, b04, b05, b06, b07, b08), (b09, b10, b11, b12, b13, b14, b15, b16), (b17, b18, b19, b20, b21, b22, b23, b24), (b25, b26, b27, b28, b29, b30, b31, b32),
     (b33, b34, b35, b36, b37, b38, b39, b40), (b41, b42, b43, b44, b45, b46, b47, b48), (b49, b50, b51, b52, b53, b54, b55, b56)) =
      ((b50, b43, b36, b29, b22, b15, b08, b01), (b51, b44, b37, b30, b23, b16, b09, b02), (b52, b45, b38, b31, b24, b17, b10, b03), (b53, b46, b39, b32, b56, b49, b42, b35),
       (b28, b21, b14, b07, b55, b48, b41, b34), (b27, b20, b13, b06, b54, b47, b40, b33), (b26, b19, b12, b05, b25, b18, b11, b04))

pc2 :: Key -> SubKey
pc2 ((b01, b02, b03, b04, b05, b06, b07, b08), (_  , b10, b11, b12, b13, b14, b15, b16), (b17, _  , b19, b20, b21, _, b23, b24), (_  , b26, b27, b28, b29, b30, b31, b32),
     (b33, b34, _  , b36, b37, _  , b39, b40), (b41, b42, _  , b44, b45, b46, b47, b48), (b49, b50, b51, b52, b53, _, b55, b56)) =
      ((b14, b17, b11, b24, b01, b05, b03, b28), (b15, b06, b21, b10, b23, b19, b12, b04), (b26, b08, b16, b07, b27, b20, b13, b02), (b41, b52, b31, b37, b47, b55, b30, b40),
       (b51, b45, b33, b48, b44, b49, b39, b56), (b34, b53, b46, b42, b50, b36, b29, b32))

rot1 :: HalfKey -> HalfKey
rot1 ((b01, b02, b03, b04), (b05, b06, b07, b08), (b09, b10, b11, b12), (b13, b14, b15, b16), (b17, b18, b19, b20), (b21, b22, b23, b24), (b25, b26, b27, b28)) =
     ((b02, b03, b04, b05), (b06, b07, b08, b09), (b10, b11, b12, b13), (b14, b15, b16, b17), (b18, b19, b20, b21), (b22, b23, b24, b25), (b26, b27, b28, b01))

rot2 :: HalfKey -> HalfKey
rot2 ((b01, b02, b03, b04), (b05, b06, b07, b08), (b09, b10, b11, b12), (b13, b14, b15, b16), (b17, b18, b19, b20), (b21, b22, b23, b24), (b25, b26, b27, b28)) =
     ((b03, b04, b05, b06), (b07, b08, b09, b10), (b11, b12, b13, b14), (b15, b16, b17, b18), (b19, b20, b21, b22), (b23, b24, b25, b26), (b27, b28, b01, b02))

split :: Key -> (HalfKey, HalfKey)
split ((b01, b02, b03, b04, b05, b06, b07, b08), (b09, b10, b11, b12, b13, b14, b15, b16), (b17, b18, b19, b20, b21, b22, b23, b24), (b25, b26, b27, b28, b29, b30, b31, b32),
       (b33, b34, b35, b36, b37, b38, b39, b40), (b41, b42, b43, b44, b45, b46, b47, b48), (b49, b50, b51, b52, b53, b54, b55, b56)) =
      (((b01, b02, b03, b04), (b05, b06, b07, b08), (b09, b10, b11, b12), (b13, b14, b15, b16), (b17, b18, b19, b20), (b21, b22, b23, b24), (b25, b26, b27, b28)),
       ((b29, b30, b31, b32), (b33, b34, b35, b36), (b37, b38, b39, b40), (b41, b42, b43, b44), (b45, b46, b47, b48), (b49, b50, b51, b52), (b53, b54, b55, b56)))

glue :: HalfKey -> HalfKey -> Key
glue ((b01, b02, b03, b04), (b05, b06, b07, b08), (b09, b10, b11, b12), (b13, b14, b15, b16), (b17, b18, b19, b20), (b21, b22, b23, b24), (b25, b26, b27, b28))
     ((b29, b30, b31, b32), (b33, b34, b35, b36), (b37, b38, b39, b40), (b41, b42, b43, b44), (b45, b46, b47, b48), (b49, b50, b51, b52), (b53, b54, b55, b56)) =
      ((b01, b02, b03, b04, b05, b06, b07, b08), (b09, b10, b11, b12, b13, b14, b15, b16), (b17, b18, b19, b20, b21, b22, b23, b24), (b25, b26, b27, b28, b29, b30, b31, b32),
       (b33, b34, b35, b36, b37, b38, b39, b40), (b41, b42, b43, b44, b45, b46, b47, b48), (b49, b50, b51, b52, b53, b54, b55, b56))


gen_subkeys :: Key -> [HalfKey -> HalfKey] -> [SubKey]
gen_subkeys key (rot:rotl) =
      let (ke, kd) = (split key)
      in let rkey = (glue (rot ke) (rot kd))
         in (pc2 rkey) : (gen_subkeys rkey rotl)
gen_subkeys _   [] = []


gen_key :: Key
gen_key =
      ((b(), b(), b(), b(), b(), b(), b(), b()), (b(), b(), b(), b(), b(), b(), b(), b()),
       (b(), b(), b(), b(), b(), b(), b(), b()), (b(), b(), b(), b(), b(), b(), b(), b()),
       (b(), b(), b(), b(), b(), b(), b(), b()), (b(), b(), b(), b(), b(), b(), b(), b()),
       (b(), b(), b(), b(), b(), b(), b(), b()))
      where
              b () = True ? False

key_to_str :: Key -> String
key_to_str ((b01, b02, b03, b04, b05, b06, b07, b08), (b09, b10, b11, b12, b13, b14, b15, b16),
            (b17, b18, b19, b20, b21, b22, b23, b24), (b25, b26, b27, b28, b29, b30, b31, b32),
            (b33, b34, b35, b36, b37, b38, b39, b40), (b41, b42, b43, b44, b45, b46, b47, b48),
            (b49, b50, b51, b52, b53, b54, b55, b56)) =
      let hex bs =
              case bs of
                      (False,False,False,False) -> "0"
                      (False,False,False,True)  -> "1"
                      (False,False,True, False) -> "2"
                      (False,False,True, True)  -> "3"
                      (False,True, False,False) -> "4"
                      (False,True, False,True)  -> "5"
                      (False,True, True, False) -> "6"
                      (False,True, True, True)  -> "7"
                      (True, False,False,False) -> "8"
                      (True, False,False,True)  -> "9"
                      (True, False,True, False) -> "a"
                      (True, False,True, True)  -> "b"
                      (True, True, False,False) -> "c"
                      (True, True, False,True)  -> "d"
                      (True, True, True, False) -> "e"
                      (True, True, True, True)  -> "f"
      in
              hex (b01,b02,b03,b04) ++ hex (b05,b06,b07,b08) ++
              hex (b09,b10,b11,b12) ++ hex (b13,b14,b15,b16) ++
              hex (b17,b18,b19,b20) ++ hex (b21,b22,b23,b24) ++
              hex (b25,b26,b27,b28) ++ hex (b29,b30,b31,b32) ++
              hex (b33,b34,b35,b36) ++ hex (b37,b38,b39,b40) ++
              hex (b41,b42,b43,b44) ++ hex (b45,b46,b47,b48) ++
              hex (b49,b50,b51,b52) ++ hex (b53,b54,b55,b56)


discover_kp :: (Key,Key) -> Success
discover_kp (k1,k2) =
      let rots =
              [ rot1, rot1, rot2, rot2, rot2, rot2, rot2, rot2,
                rot1, rot2, rot2, rot2, rot2, rot2, rot2, rot1 ]
      in
              let kv1 = gen_subkeys (pc1 k1) rots
                  kv2 = gen_subkeys (pc1 k2) rots
              in
                      (kv1 =:= (reverse kv2)) & ((k1,k2) =:= (gen_key, gen_key))


print_kp :: (Key,Key) -> IO ()
print_kp (k1,k2) =
      putStrLn
              ((if (k1 == k2) then "| Weak......:" else "| Semi-weak.:") ++
               " " ++ (key_to_str k1) ++ " " ++ (key_to_str k2) ++ " |")


main :: IO ()
main =
      do
              putStrLn ("+-------------------------------------------+")
              putStrLn ("|    Type    |     Key 1     |     Key 2    |")
              putStrLn ("+-------------------------------------------+")
              mapIO_ print_kp (findall discover_kp)
              putStrLn ("+-------------------------------------------+")
