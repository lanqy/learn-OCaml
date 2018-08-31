match 4 with x -> x;;

match 4 with xyz -> xyz;;

match [3; 4; 5] with [a; b; c] -> b;;

match (3, 7, 4) with (a, b, c) -> c;;

match (3, 4, (8, 9)) with (a, b, c) -> c;;

let sign x = 
    match x with
    x when x < 0 -> -1
    | 0 -> 0
    | x -> 1;;

sign (-2);;

sign 1;;

sign 0;;

sign 100;;

let getPassword passw = 
    match passw with
    "hello" -> "OK. Safe Opened."
    | _ -> "Wrong Password Pal.";;

getPassword "hellow";;

getPassword "Pass";;

getPassword "hello";;