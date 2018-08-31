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

let fst (a, _) = a;;

let snd (_, b) = b;;

fst (2, 3);;

fst ("a", 23);;

snd (2, 3);;

snd (2, "a");;

List.map fst [("a", 12); ("b", 23); ("c", 23); ("d",67)];;

List.map snd [("a", 12); ("b", 23); ("c", 23); ("d",67)];;

let tpl3_1 (a, _, _) = a;;
let tpl3_2 (_, a, _) = a;;
let tpl3_3 (_, _, a) = a;;

tpl3_1 (2, "OCaml", 2.323);;
tpl3_2 (2, "OCaml", 2.323);;
tpl3_3 (2, "OCaml", 2.323);;

let divmod a b = a / b, a mod b;;

divmod 10 3;;

let swap (x, y) = (y, x);;

swap (2, 3);;

List.map swap [("a", 12); ("b", 23); ("c", 23); ("d", 67)];;