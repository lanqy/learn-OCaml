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