{- Property Grammar -}
{-# LANGUAGE OverloadedStrings #-}

module PropertyLang where

data Property
  = FunctionClass Int Int
  | DeviceClass Int
  | And Property Property
  | Not Property
  | Or Property Property
  deriving (Read, Eq, Show)

-- Function to generate the C predicate for Property
propertyToC :: Property -> String
propertyToC (DeviceClass n) = "(sec_device.class == " ++ show n ++ ")"
propertyToC (FunctionClass f n) =
  "(!"
    ++ "sec_device.functions["
    ++ show f
    ++ "].exists || "
    ++ "sec_device.functions["
    ++ show f
    ++ "].class == "
    ++ show n
    ++ ")"
propertyToC (Not p) = "!(" ++ (propertyToC p) ++ ")"
propertyToC (And p1 p2) =
  "(" ++ (propertyToC p1) ++ " && " ++ (propertyToC p2) ++ ")"
propertyToC (Or p1 p2) =
  "(" ++ (propertyToC p1) ++ " || " ++ (propertyToC p2) ++ ")"

code_pre =
  "typedef struct seccom_function {char exists; char class;} seccom_function;\n"
  ++ "typedef struct seccom_device {char class; seccom_function functions[8];} seccom_device;\n" ++ "seccom_device sec_device;\n"

generatePropertyFunction :: Property -> String
generatePropertyFunction p =
  "int check_sec_device() { return " ++ propertyToC p ++ "; }"


generatePciAddDevice :: String
generatePciAddDevice = "init_sec_device(); if (!check_sec_device()) return 0;"
