(* 字符转码 *)

(***
Sequence  ASCII     Name
\\        \         Backlash
\"        "         Double Quote
\'        '         Double Quote
\n        LF        Line Feed
\r        CR        Carriage Return
\t        TAB       Horizontal tabulation
\b        BS        Backspace
'\ '      SPC       Space
\nnnn     nnn       Decimal Code of Acii Character
\xhhh     xhh       Hexadecimal Code of Ascii Character
***)

'\\';;
'\ ';;
'\"';;
'\r';;
'\n';;
'\t';;
'\ ';;
'\098';;
'\x21';;

(* 原始类型 *)

(* Boolean          *)
(*------------------*)
true;;
false;;

(* Int              *)
(*--------------------
*  在32位机器中32位签名int
*  在64位计算机中64位签名
*)

1000;;

(* 二进制 int *)
0b1000111011 ;;

(* 十六进制 int *)
0xf0057a3 ;;

(* 八进制 int *)
0o73456;;

(* Floats                   *)
(* ------------------------ *)
3.23e3 ;;
34.2E-5 ;;
232.;;

(* Char                     *)
(* ------------------------ *)

'a';;
'\n';;
'\231';;

(* 字符串                         *)
(* ------------------------------- *)

"Hello world OCaml";;

(* 元组                            *)
(* ----------------------------------*)
"Hello world OCaml";;
(10, 203.2322);;
("hello", 'w', 10);;

(* 列表/是不可变数据结构  *)
(*----------------------------------------*)
[10;20;30;40;1;3];;
["hello";"world";"ocaml"];;
[(1, 'a'); (2, 'b'); (3, 'c')];;

(* 数组 / 可变数据结构  *)
(* --------------------------------- *)
[|23;200;300;400|];;
[|123.23; 10.23; 50.53; -80.23; 30.9734; 50.25 |];;
[|'o';'c';'a';'m';'l'|]

(* Unit / 代表副作用（类似于Haskell IO ()*)
(*-------------------------------------------------------- *)
();;
print_string;;
read_line;;
let read_two_lines () = read_line (); read_line (); print_string "two lines";;

read_two_lines ();;

(* 选项类型 / 相当于Haskell Maybe *)
None;;
Some 10;;
Some 'a';;
Some "OCaml";;

(* 运算符 *)

(* 浮点数函数必须是 +. /. -. *. 操作符，因为OCaml 不支持操作符负载 *)

(* 布尔运算符 *)
(* NOT                  *)
(*----------------------*)
not;;

not false;;
not true;;

(* AND                  *)
(*----------------------*)

(&&);;
(&&) true false;;

true && true;;

true && false;;

(* OR                   *)
(*----------------------*)
(||);;
(||) false true;;
true || true;;
true || false;;

false || false;;

(* 比较 *)

(* 相等 *)
(=);;
(==);;

(* 不等式 *)
(<>);;

(<);;
(<=);;
(>=);;
(>);;

max;;
min;;
compare;;

2 <> 4;;
2 != 4;;
3 != 3;;
max 3 100;

min 2.323 100.33;;

(+);;
(-);;
(+.);;
(-.);;

(* 整数运算符 *)
23 + 234;;
1000 / 4;;

1005 mod 10;;

abs (-10);;
abs 10;;

pred 100;;

pred 99;;

succ 101;;

(* Float Point *)
(*-------------*)

100. +. 23.23;;

0.545 *. 100.;;

1000. /. 4.;;

1000.0 -. 4.0;;

(* Pow function 2^4 = 16 / only works for float points *)

2.0 ** 4.;;

( **);;

(* 变量声明 *)
let x = 2;;

(* 声明类型 *)
let a: float = 2.323;;

(* 字符和字符串 *)

'a';;
"hello world";;

(* 列表 *)
[1;2;3;4;5];;
[1.;2.;3.;4.];;
["hello";"world";"ocaml";"amazing"];;

(****** 元组 ***********)

(90, 100);;
(232, 23.232, "hello ", 'c');;
("hello", 23.23);;

(* 本地绑定 *)
let x = 10 in
let y = 3 in
let z = 4 in
(x, y, z);;

x;;
y;;
z;;

(****************)
let z = 
    let x = 10 in
    let y = 20 in
    x + 2 * y;;
z;;
x;;
y;;

(****************)
let a = 
    let f1 x = 10 * x in
    let fxy x y = 3 * x + 4 * y in
    let z = 3 in
    f1 z + fxy 3 4 + f1 6;;

a;;
f1;;
fxy;;

(****************)
let a, b, c = 
    let f1 x = 3 * x in
    let f2 x y = 5 * x - 3 * y in
    let a = 3 in
    let b = 4 in
    let c = a + b in
    (f1 a, f2 a b, a + b + c);;

f1;;
f2;;

(* 多态函数 *)
let id = fun x -> x;;

id 10.23;;

id 100;;

id "Hello world";;


(* Number Formats *)
(* 31 bits signed int, since this machine has 32 bits word lenght*)

Pervasives.min_int;;

Pervasives.max_int;;

(* 32 bits signed int *)

Int32.max_int;;
Int32.min_int;;

(* 64 bits signed int *)
Int64.min_int;;
Int64.max_int;;

(* IEEE.754 - 64 bits double precision - float point *)
Pervasives.min_float;;
Pervasives.max_float;;

(* Numeric Literals *)
23213;;
0xf43aaec;;
0b10001110011;;

(* 32 bits signed int *)

232131;;
0xf41231;;
0b1111100011110011l;;

(* 64 bits signed int *)
1000000L;;
0xff2562abcL;;
0b11111000111100110011111101L;;

(* Number Conversion / Type Casting *)
Int32.of_int 10002373;;
Int32.of_float 23232.323;;
Int32.of_string "98232376";;
Int32.to_int 1000331;;

Int64.of_int 100;;
Int64.of_float 1000239823.2323;;

Int64.of_string "3423912";;

Int64.to_int 2323884L;;

int_of_float (-1235.34083402321);;

Pervasives.int_of_float (-1235.34083402321);;

int_of_string "9123";;

float_of_string 1000;;


(+);;

(+.);;

Int32.add;;
Int64.add;;
Big_int.add_big_int;;
23423 + 1213;;
32.34 +. 232.22;;
Int32.add 23231 60231;;
Int64.add 232L 3434L;;

(* Simplifying Number Operators *)

let fun1 x y = 10 * x - 4 * y;;
fun1 45 23;;

let fun1L x y = 
    let (-) = Int64.sub in
    let ( * ) = Int64.mul in
    10L * x - 4L * y;;

fun1L 45L 23L ;;

(* Trick Creating an Operator Module *)
module OP = struct
    module FL = struct
        let (+) = (+.)
        let (-) = (-.)
        let ( * ) = ( *. )
        let (/) = (/.)
    end

    module I32 = struct
        let (+) = Int32.add
        let (-) = Int32.sub
        let (/) = Int32.div
        let ( * ) = Int32.mul
    end

    module I64 = struct
        let (+) = Int64.add
        let (-) = Int64.sub
        let ( * ) = Int64.mul
        let (/) = Int64.div
    end
end 

(* Defined for int *)

let fun1 x y = 10 * x - 4 * y;;
fun1 100 20;;

(* Defined for Int32 *)
let fun1_int32 x y = 
    let open OP.I32 in
    10l * x - 4l * y;;

fun1_int32 100l 20l;;

(* OR for short *)
let fun1_int32_ x y = OP.I32.(10l * x - 4l * y);;

fun1_int32_ 100l 20l;;

(* Defined for Int64 *)

let fun1_int64 x y = 
    let open OP.I64 in
    10L * x - 4L * y;;

fun1_int64 100L 20L;;

(* OR *)
let fun1_int64_ x y = OP.I64.(10L * x - 4L * y);;

(* Defined for Float *)
let fun1_float x y = 
    let open OP.FL in
    10. * x - 4. * y;;

fun1_float 100. 20.;;

(* OR *)
let fun1_float_ x y = OP.FL.(10. * x - 4. * y);;
fun1_float_ 100. 20.;;


(* Math / Float Functions *)

(* Operators *)

(+.);;
(-.);;
(/.);;
( *. );;

(* Power operator/ Exponentiation *)

( ** );;

List.map ((+.) 2.323) [10.23;3.4;30.;12.];;

List.map (( *. ) 3.) [10.23;3.4; 30.;12.];;

List.map (fun x -> 2. ** x) [1.;2.;3.;4.;5.;6.;7.;8.];;

(* 绝对值 *)

abs_float;;

(* 平方根 *)

sqrt;;

(* 三角函数 *)
sin;;
cos;;
tan;;
atan;;
atan2;;

acos;;
asin;;

(* 曲线函数 *)
cosh;;
sinh;;
tanh;;

(* Logarithm and exp *)
log;;
log10;;
exp;;

 (* exp x -. 1.0, *)
expm1;;

(*  log(1.0 +. x)  *)
log1p;;

(* Remove Decimal Part *)
floor;;

ceil;;

truncate;;

int_of_float;;

(* Float Constants *)

infinity;;
neg_infinity;;
max_float;;
min_float;;
nan;;
1. /. 0.;;
-1 /. 0.;;

(* Function Declaration *)

let x = 34;;
x;;
let x = 10 in
let x = 20 in
let z = x * y in
z - x -y;;

let x = 10.25 in
let y = 30. in
x *. y;;

let f x = 10 * x + 4;;
f 4;;
f 5;;
let f (x, y) = x + y;;
f (2, 5);;

f (10, 5);;

let add_floats x y = x +. y;;
add_floats 10. 50.232;;

let a_complex_function x y = 
    let a = 10 * x in
    let b = 5 * y + x in
    a + b;;

(*
    a_complex_function 2 3
        a = 10 * x -->  a = 10*2 = 20
        b = 5 * 3  -->  b = 5*3 + 2 = 17
        a + b      -->  20 + 17 = 37
*)

a_complex_function 2 3;;

(* Function Inside functions *)

let func1 x y = 
    let ft1 x y = 10 * x + y in
    let ft2 x y z = x + y - 4 * z in
    let ft3 x y = x - y in
    let z = 10 in
    (ft1 x y) + (ft2 x y z) - (ft3 x y);;

func1 4 5;;
func1 14 5;;

func1 20 (-10);;

(* Returning More than one value *)

let g x y = (10 * x, x + y);;

g 4 5;;

(* Declaring Functions with type signature. *)

let func1 (x: int) (y:float):float = (float_of_int x) +. y;;

func1 10 2.334;;

let func2 (xy: (int * int)): int = (fst xy) + (snd xy);;
func2 (5, 6);;

let show (x:float) = Printf.printf "%.3f" x;;

show 3.232;;

let showxy (x, y): unit = Printf.printf "%.3f\n" (x +. y);;

showxy (32.323, 100.232);;

let doubel_list (list_of_floats: float list): float list = 
    List.map (fun x -> 2.0 *. x) list_of_floats;;

doubel_list [1.;2.;3.;4.;5.];;

(* Declaring function type with anonymous functions. *)
let func2' : (int * int) -> int = fun (a, b) -> a + b;;

func2' (5, 6);;

let showxy' : float * float -> unit = fun (x, y) ->
    Printf.printf "%.3f\n" (x +. y);;

showxy' (23.3, 5.34021);;

(* Declaration functions that takes another function as argument *)
let apply_to_fst f (x, y) = (f x, y);;
let apply_to_fst2: ('a -> 'c) -> 'a * 'b -> 'c * 'b = 
    fun f (x, y) -> (f x, y);;

let f x = x + 10;;
apply_to_fst f (10, "hello world");;
apply_to_fst2 f (10, "hello world");;

(* Declaring functions with custom types *)
type tuple_of_int = int * int;;
type func_float_to_string = float -> string;;

type func_tuple_of_ints_to_float = int * int -> float;;
let x:tuple_of_int = (10, 4);;
let f: func_float_to_string = fun x -> "x = " ^ (string_of_float x);;

f 2.23;;

let funct : tuple_of_int -> int = fun (x, y) -> x + y;;
funct (10, 100);;

let fxy : func_tuple_of_ints_to_float =
    fun (x, y) -> 10.4 *. (float_of_int x) -. 3.5 *. (float_of_int y);;

fxy;;

fxy (10, 5);;

type list_of_float = float list;;

let double (xs: list_of_float):list_of_float = List.map (fun x -> 2.0 *. x) xs;;

double [1.;2.;3.;4.;5.];;

double;;

let double2 : list_of_float -> list_of_float =
    fun xs -> List.map (fun x -> 2.0 *. x) xs;;

double2;;
double2 [1.;2.;3.;4.;5.];;

(* Functions with Named Parameters *)
let f1 ~x ~y = 10 * x - y;;
f1;;

f1 4 5;;
f1 20 15;;

(* Currying Funcctions with named parameters *)

f1 20;;
f1 ~x:20;;
let f1_20 = f1 ~x:20;;

f1_20 10;;

f1_20 40;;

List.map (fun y -> f1_20 y) [1;2;10;20;30];;

let show_msg x ~msg () = Printf.printf "%s = %d" msg x;;

show_msg 2 "Hello world" ();;

show_msg 20;;

let f = show_msg 20;;

f "x" ();;
f "y" ();;
List.iter f ["x"; "y"; "z"; "w"];;

List.iter (fun msg -> f msg ()) ["x"; "y"; "z"; "w"];;

(* Functions with Optional Parameters: *)

(*
    If the parameter x is not given, x will be set to 100
*)

let f ?(x = 100) y = 10 * x - 5 * y;;

f;;

(*
    f 20 ==> (10*x - 5*y) 100 20
             (10 * 10 - 5 * 20 )
             (1000 - 100)
             900
 *)

f 20;;

(*
    f 60 ==> (10*x - 5*y) 100 60
             (10*100 - 5*60)
             (1000 - 300)
             700
*)

f 60;;

List.map f [10;20;30;40;50];;

f ~x:40 20;;

f ~x: 50 20;;

f ~x:40;;

let f_x40 = f ~x: 40;;

List.map f_x40 [10;20;30;40;50];;

List.map (f ~x: 40) [10;20;30;40;50];;

let rectangle_area ?(width = 30) ~height = width * height;

rectangle_area 20;;
rectangle_area 30;;

List.map rectangle_area [10;20;30;40;50];;
List.map (fun h -> rectangle_area h) [10;20;30;40;50];;
rectangle_area ~width:200;;
rectangle_area ~width:200 ~height:20;;

List.map (fun h -> rectangle_area ~height:h ~width:30) [10;20;30;40;50];;

(* Function Composition *)
(* Operators: *)
let (<<) f g x = f (g x);;

(* F# Piping Composition Operator *)
let (>>) f g x = g(f x);;

(* F# Piping Operator *)
let (|>) x f = f x;;
let (<|) f x = f x;;

(* Composition Operator *)
let f1 x = 10 + x;;
let f2 x = 2 * x;;
let f3 x = x - 8;;
f1(f2 (f3 10));;

(f1 << f2 << f3) 10;;

let f = f1 << f2 << f3;;

(* Pipe Operators *)

10 |> f3 |> f2 |> f1;;

10 |> f3;

2 |> f2;

4 |> f1;

10 |> (f3 >> f2 >> f1);;

f3 >> f2 >> f1 <| 10;;

(* Lambda Functions/ Anonymous Functions *)

fun x -> x + 1;;

fun x -> x +. 1.0;;

fun x -> x ^ x;;

fun (x, y) -> x + y;;

fun (x, y) -> (y, x);;

fun x y -> (x, y);;

fun x y z -> (x, y, z);;

fun x -> x + 1;;

(fun x -> x + 1) 10;;

let f = fun x -> x + 1;;

f 10;;

List.map (fun x -> x + 1) [1;2;3;4;5];;

(* x = 1 *)
(fun x y z -> 10 * x + 4 * z - 3 * x * y) 1;;

(* x = 1 y = 2 *)
(fun x y z -> 10 * x + 4 * z - 3 * x * y) 1 2;;

(* x = 1 y = 2 z = 3 *)
(fun x y z -> 10 * x + 4 * z - 3 * x * y) 1 2 3;;

(* Partial Evaluation *)
(*----------------------*)
let f = fun x y z -> 10 * x + 4 * z - 3 * x * y;;

(f 1);;

((f 1) 2);;

(((f 1) 2) 3);;

f 1 2 3;;

(* x= ?, y=?, z=3 The variables x and y varies *)
List.map (fun (x, y) -> f x y 3) [(1, 2); (3, 4),(5, 6)];;

(* x= ?, y=2, z=? The variables x and z varies *) 
List.map (fun (x, z) -> f x 2 z) [(1, 2);(3, 4),(5,6)];

(** Filtering                      *)
(**--------------------------------*)

List.filter (fun x -> x > 5) [1;2;3;4;5;6;7;8;9;10];;

List.filter (fun (x, y) -> x + y > 10) [(-10, 30); (5, 4); (12, -8); (9, 8)];;

[(-10, 30); (5, 4); (12, -8); (9, 8)] |> List.filter (fun (x, y) -> x + y > 10);;

[(-10, 30); (5, 4); (12, -8); (9, 8)]
|> List.filter (fun (x, y) -> x + y > 10)
|> List.map (fun (x, y) -> 4 * x + 3 * y);;

(*  Recursive Functions *)

let rec factorial1 n = 
    match n with
    | 0 -> 1
    | 1 -> 0
    | k -> k * factorial1 (k -1);;

let rec factorial2 = function
    | 0 -> 1
    | 1 -> 1
    | n -> n * factorial2 (n - 1);;

factorial1 5;;
factorial2 5;;

let rec map f xs = 
    match xs with
    | [] -> []
    | h::tl -> (f h)::(map f tl);;

map ((+) 5) [10;20;25;9];;

let rec sumlist =  function
    | [] -> 0
    | [a] -> a
    | (hd::tl) -> hd + sumlist tl;;

sumlist [1;2;3;4;5;6;7;8;9];;

let rec prodlist = function
    | [] -> 1
    | [a] -> a
    | (hd::tl) -> hd * prodlist tl;;

prodlist [1;2;3;4;5;6];;

let rec filter f xs = 
    match xs with
    | [] -> []
    | h::tl -> if f h
               then h::(filter f tl)
               else filter f tl;;

filter (fun x -> x < 10) [1;2;3;4;5;6;10;30;20];;

let rec take n xs = 
    match (n, xs) with
    | (0, _) -> []
    | (_, []) -> []
    | (k, h::tl) -> k::(take (n - 1) tl);;

take 3 [1;2;3;4;5;6];;

take 20 [20;19;18;17;16;15;14];;

let rec drop n xs = 
    if n < 0 then failwith "n negative"
    else
        match (n, xs) with
        | (0, _) -> xs
        | (_, []) -> []
        | (k, h::tl) -> drop (k - 1) tl;;

drop (-10) [1;2;3;4;5;6;7;8;9];;

drop 10 [];;

drop 0 [1;2;3;4;5;6;7;8;];;

drop 5 [1;2;3;4;5;6];;

drop 25 [1;2;3;4;5;6];;

(*

    Haskell Function:
    foldl1 : ( a -> a -> a ) -> [a] -> [a]

    > foldl1 (\x y -> 10*x + y) [1, 2, 3, 4, 5]
    12345

    foldl1 f  [1, 2, 3, 4, 5]  =
    f 5 (f 4 (f 3 (f 1 2)))

    foldl f [x0, x1, x2, x3, x4, x5 ... ] =

    f xn (f xn-1 (f xn-2 ... (f x3 (f x2 (f x1 x0))))) ....

    From: http://en.wikipedia.org/wiki/Fold_%28higher-order_function%29
*)

let rec foldl1 f xs = 
    match xs with
    | [] -> failwith "Empty list"
    | [x] -> x
    | (x::y::tl) -> foldl1 f (f x y :: tl);;

foldl1 (fun x y -> 10 * x + y) [1;2;3;4;5];;

let rec foldr1 f xs =
    match xs with
    | [] -> failwith "Empty list"
    | [x] -> x
    | x::tl -> f x (foldr1 f tl);;

foldr1 (fun x y -> x + 10 * y) [1;2;3;4;5;6];;

let rec foldr f acc xs =
    match xs with
    | [] -> acc
    | x::tl -> f x (foldr f acc tl);;

foldr (fun x y -> x + 10 * y) 0 [1;2;3;4;5;6];;

let rec foldl f acc xs = 
    match xs with
    | [] -> acc
    | x::tl -> fold1 f (f acc x) tl;;

fold1 (fun x y -> 10 * x + y) 0 [1;2;3;4;5;6];;

let rec range start stop step =
    if start > stop
    then []
    else start::(range (start + step) stop step);;

range 0 30 1;;

range 0 100 10;;

range (-100) 100 10;;

(* Mutable References *)

(** Declare a reference *)
let x = ref 0;;

(** Get the value of a reference *)
!x;;

(** Set the value of a reference *)
(:=);;

x := 100;;

(** Update a reference *)
x:= !x + 100;;
x;;

(** A reference can be accessed inside a function *)
let x = ref 10;;

let add_10_to_x () =
    x := !x + 10;;

add_10_to_x ();;

(** Functions that operates references *)

let y = ref 10;;

let get_ref x = !x;;

get_ref y;;

let set_ref r new_value =
    r := new_value;;

set_ref y 100;;

let add_x_to_ref r x =
    r := !r + x;;

add_x_to_ref y 200;;

(* 
    y <-- y + 1 + 2 + 3 + 4 + 5 + 6 
*)
List.iter (add_x_to_ref y) [1;2;3;4;5;6];;
y;;

(*******************)
let y = ref 10;;

let add_10_to_ref r = 
    r := !r + 10;;

add_10_to_ref y;;

add_10_to_ref y;;

(*********************************)
let swap_ref a b =
    let c = !a in
        a := !b
        b := c;;
let x = ref 10;;
let y = ref 20;;

swap_ref x y;;

x;;

y;;

(** Capturing references with closures *)
let make_counter () =
    let i = ref 0 in
    fun () ->
        i := !i + 1;
        !i;;

let counter1 = make_counter ();;

counter1 ();;
counter1 ();;
counter1 ();;
counter1 ();;

let counter2 = make_counter ();;
counter2 ();;
counter2 ();;
counter1 ();;

let lst = ref [1.0;2.0;3.0];;

!lst;;

List.nth (!lst) 0;;
List.nth (!lst) 2;;

lst := List.map (fun x -> x *. 2.) !lst;;

lst;;

(* Control Structures *)

(* Conditional Expressions *)
let test x =
    if x > 0
    then print_string "x is positive"
    else print_string "x is negative";;

test 10;;
text (-10);;

let sign x = 
    if x = 0
        then 0
    else if x > 0
        then 1
        else (-1);;

List.map sign [1;-1;0;2;3];;

(* For Loop *)

for i = 0 to 5 do
    Printf.printf "= %i\n" i 
done;;

for i = 10 downto 1 do
    Printf.printf "%d .." i
done;;

(* While Loop *)
let j = ref 5;;

while !j > 0 do
    Printf.printf "x = %d\n" !j; j := !j - 1
done;;

(* Infinite While Loop *)

let mainloop () =
    while true do
        print_string "hello world / hit return to continue";
    done;
    ;;