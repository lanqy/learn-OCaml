(* 阶乘普通版本 *)
let rec fact x = 
    if x <= 1 then 1 else x * fact (x - 1)

(* 阶乘模式匹配版本 *)
let rec fact x = 
    match x with
    | 0 -> 1
    | x -> x * fact (x - 1)

(* 相互递归例子 *)
let rec even n = 
    match n with
    | 0 -> true
    | x -> odd (x - 1)
and odd n = 
    match n with
    | 0 -> false
    | x -> even (x - 1)


(* 列表合并 *)
[] @ [];;
let a = [1;2] @ [3;4];;


(* 找到整数列表的总和的例子: *)
let rec total l = 
    match l with
    [] -> 0
    | h :: rest -> h + (total rest);;

(* function 表达式版本 *)
let rec total = function
    [] -> 0
    | h :: rest -> h + (total rest);;



(* 反转列表的函数示例 *)
let reverse l = 
    let rec innerReverse l1 l2 = 
        match l1 with
        | [] -> l2
        | h :: rest -> innerReverse rest (h :: l2);;
    in
    innerReverse l [];;

(* map 函数的例子 *)
let rec map fn = function
    | [] -> []
    | h :: rest -> fn h :: map fn rest;;

(* fold (折叠)函数例子 *)

(* 左fold *)
let rec foldl fn acc l =
    match l with
    | [] -> []
    | h :: rest -> foldl fn (fn acc h) rest;;

(* 用于查找列表长度的 fold 示例 *)
(* fold1 (fun acc x -> acc + 1) 0 [1;2;3];; *)