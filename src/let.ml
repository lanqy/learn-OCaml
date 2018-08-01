let x = 2 + 3 in 
x * x;;

let x = 2 in
let squared = x * x in
let cubed = x * squared in
squared * cubed;;

let two = 2.0 in
let zero = 0.0 in
two *. zero;;

let a = "a" in
let b = "b" in
let aaa = a ^ a ^ a in
let bbb = b ^ b ^ b in
aaa ^ bbb;;

let x = e1 in 
e2;;

let x = 3 + 4 in
string_of_int x;;

let add_one (x: int): int = 1 + x;;

let add_two (x: int): int = add_one (add_one x);;

let add_two' (x: int): int = 
    let add_one x = 1 + x in
    add_one (add_one x)
;;

let add (x:int) (y:int): int = x + y;;

(* 函数的类型
    add_one : int -> int
    add_two : int -> int
    add : int -> int -> int
 *)

 let x = 3;;

 let add_three (y:int): int = y + x ;;

 let x = 4;;

 let add_four (y:int): int = y + x ;;

 let add_seven (y:int): int = 
    add_three (add_four y)
;;

(*  元组 
    Tuples
*)

(* 
    (1, 2) : int * int
    ("hello", 7 + 3, true) : string * int * bool
    ('a', ("hello", "goodbye")) : char * (string * string)
 *)

 let (id1, id2, …, idn) = e1 in e2

let (x, y) = (2, 4) in x + x + y;;


(* 两点之间的距离 *)

type point = float * float;;

let distance (p1:point) (p2:point): float = 
    let square x = x *. x in
    let (x1, y1) = p1 in
    let (x2, y2) = p2 in
    sqrt (square (x2 -. x1) +. square (y2 -. y1))
;;

let pt1 = (2.0, 3.0);;
let pt2 = (0.0, 1.0);;
let dist12 = distance pt1 pt2;;


(* 练习 *)

let x = 22 + 10;;

let x1 = 22.0 +. 20.0;;

let cos326_loveifier input = input ^ ", and that is why I love cos326";;

let difference_between_num_and_42 num = num - 42;;

(* let volume_cylinder (h:float) (r:float) : float = PI *. r *. r *. h;; *)

let even x = 
    match x mod 2 with
    0 -> true
    | x -> false;;
