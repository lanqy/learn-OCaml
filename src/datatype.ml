(*  http://www.cs.cornell.edu/courses/cs3110/2016fa/l/04-data/lec.pdf
    let 表达式
    语法：let x = e1 in e2    
    x 是标识符
    e1 是绑定表达式
    e2 是主体表达式
    let x = e1 in e2 本身也是一个表达式
*)

let x = 2 in x + x;; (* ==> 4 *)

let inc x = x + 1 inc 10;; (* ==> 11 *) 

let y = "big" in
let z = "red" in
y^z;; (* ==> "bigred" *)

let x = 1 + 4 in x * 3;;
(* -> 将 e1 计算为值 v1 *)
let x = 5 in x * 3;;
(* 在 e2 中用 x 替换 x ，产生一个新的表达式 e2' *)
5 * 3;;
(* 计算 e2' 到 v2 *)
15
(* 计算结果为 v2 *)

(* 这两个表达式在语法上是不同的,但在语义上等同： *)
let x = 2 in x + 1;;
(fun x -> x + 1) 2;;

(* 变种 *)

type day = Sun | Mon | Tue | Wed | Thu | Fri | Sat;;

let int_of_day d =
    match d with
    | Sun -> 1
    | Mon -> 2
    | Tue -> 3
    | Wed -> 4
    | Fri -> 6
    | Sat -> 7;;

(* 创建和解构变种 *)
(* 语法：type t = C1 | ... | Cn *)

type ptype = 
    TNormal
    | TFire
    | Twater;;

type peff = 
    ENormal
    | ENotVery
    | ESuper;;

let eff_to_float = function
    | ENormal -> 1.0
    | ENotVery -> 0.5
    | ESuper -> 2.0;;

(* 记录和元组 *)

(* 记录 *)
type mon = {name: string; hp: int; ptype: ptype};;

(* 构造记录 *)
let r = {name = "Charmander"; hp = 39; ptype = TFire};;

(* 要解构和访问记录的字段：r.hp *)
(* 或者可以使用模式匹配记录模式：{f1 = p1; ...; fn = pn} *)

(* 模式匹配记录 *)

(* OK *)
let get_hp m = 
    match m with
    | {name = n; hp = h; ptype = t} -> h;;

(* better *)
let get_hp m =
    match m with
    | {name = _; hp = h; ptype = _} -> h;;


(* 高级模式匹配记录 *)

(* better *)
let get_hp m = 
    match m with
    | {name; hp; ptype} -> hp;;

(* better *)
let get_hp m = 
    match m with
    | {hp} -> hp;;

(* best *)
let get_hp m = m.hp;;

(*
按名称与按位置 
记录字段按名称标识
- 我们在表达式中写字段的顺序是无关紧要的
相反的选择：按位置确定
 *)


(* 元组 *)
(* 几个数据粘在一起 *)
(* 元组包含几个组件 *)
(* （使用前不必定义元组类型） *)
(* 例如： *)
(1,2,3);;

(true, "Hello");;

([1;2;3], (0.5, 'x'));;

(* 解构元组 *)
(* 元组模式: (p1, ..., pn) *)

let tuples = 
    match (1,2,3) with
    | (x, y, z) -> x + y + z;; (* ==> 6 *)

let thrd t = 
    match t with
    | (x, y, z) -> z;;

(* 无匹配的模式匹配 *)

(* OK *)
let thrd t =
    match t with
    | (x, y, z) -> z;;

(* good *)
let thrd t = 
    let (x, y, z) = t in z;;

(* better *)
let thrd t = 
    let (_, _, z) = t in z;;

(* best *)
let thrd (_, _, z) = z;;

(* 模式匹配参数 *)

(* OK *)
let sum_triple t = 
    let (x, y, z) = t
    in x + y + z;;

(* better *)
let sum_triple (x, y, z) = x + y + z;;

(* 解构对 *)
let fst (x, _) = x;;
let snd (_, y) = y;;

let (x, y) = snd("big", ("red", 42))
in (42, y);;

let eff = function
    | (TFire, TFire) -> ENotVery
    | (TWater, TWater) -> ENotVery
    | (TFire, TWater) -> ENotVery
    | (TWater, TFire) -> ESuper
    | _ -> ENormal;;