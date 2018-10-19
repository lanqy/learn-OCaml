(* 一些代码片段 *)

let rec fact n = 
    if n < 2 then 1
    else n * fact(n - 1);;

let rec sum lst = 
    match lst with
    [] -> 0
    | head :: tail -> head + sum tail;;

let rec pat func value lst = 
    match lst with
    [] -> value
    | head :: tail -> func head (pat func value tail);;

let add a b =  a + b;;

let patsum = pat add 0;;

let dup a b = a * 2 :: b;;

let patdup = pat dup [];;

let pat2 func lst = 
let op1 a b =  func a :: b in
let opt2 = pat op1 [] in
op2 lst;;

let duplicate a = a * 2;;

pa2 duplicate [1;2;3];;