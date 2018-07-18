(* http://www.cs.cornell.edu/courses/cs3110/2016fa/l/02-fun/lec.pdf 函数定义 *)
(* 语法 *)
(* let rec f x1 x2 ... xn = e *)
(* 不是递归的函数 rec 可以省略 *)

(* 类型 t -> u 是需要的函数的类型，输入类型为 t 并返回类型为 u 的输出 *)

(* 类型 t1 -> t2 -> u 是函数的类型，接受类型为 t1 的输入和另一个输入 t2 并返回类型为 u 的输出 *)

(* 函数定义 *)
let rec pow x y =
    if y = 0 then 1
    else x * pow x (y-1);;

(* 带类型的函数定义 *)
let rec pow (x: int) (y: int) : int = 
    if y = 0 then 1
    else x * pow x (y - 1);;

let cube x = pow x 3;;

let area_rect w h = w *. h;;

let foo = area_rect (1.0 *. 2.0) 11.0;;

(* 匿名函数语法 fun x1 ... xn -> e *)

(* 语法不同，但是语义相同 *)
let inc = fun x -> x + 1;;

(fun x -> x + 1) 2;;

let inc x = x + 1;;

let square x = x * x;;

(* 管道运算符 *)
let a = 5 |> inc |> square;; (* 36 *)
