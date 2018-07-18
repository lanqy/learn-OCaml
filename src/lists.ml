(*** 
    [] 是空列表
    e1 :: e2 将元素 e1 添加到列表 e2 之前
    [E1;E2;...; en] 是 e1 :: e2 :: ... :: en ::[] 的语法糖
 ***)
let lst = [1;2;3];;

let empty = [];;

let longer = 5 :: lst;;
let another = 5 :: 1 :: 2 :: 3 :: [];;

let rec sum xs = 
    match xs with
    | [] -> 0
    | h :: t -> h + sum t;;

let six = sum lst;;
let zero = sum empty;;

let empty lst = 
    match lst with
    | [] -> true
    | h :: t -> false;;


(* 列表函数示例 *)
let rec sum xs = 
    match xs with
    | [] -> 0
    | h :: t -> h + sum t;;

let rec length xs = 
    match xs with
    | [] -> 0
    | h::t -> 1 + length t;;

let rec append lst1 lst2 = 
    match lst1 with
    | [] -> lst2
    | h :: t -> h :: (append t lst2);;


(*** 匹配表达式
    语法：
    match e with
    | p1 -> e1
    | p2 -> e2
    | …
    | pn -> en
 ***)

let empty lst = 
    match lst with
    | [] -> true
    | h :: t -> false;;

let f x = 
    match x with
    | p1 -> e1
    | ...
    | pn -> en

(* 可以使用另一段语法糖 *)

let f = function
    | p1 -> e1
    | ...
    | pn -> en
