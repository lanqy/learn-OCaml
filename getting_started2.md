## OCaml简介第2部分

### 递归多层数据结构。
* 列表类型
```ocaml
# [1;2;3;4;5];;
- : int list = [1; 2; 3; 4; 5]
# ["a"; "b"; "c"];;
- : string list = ["a"; "b"; "c"]

(* 不同的类型不能存在于同一个列表 *)
# [1; "a"];;
Error: This expression has type string but an expression was expected of type int
```

### 将值添加到列表的开头

* 使用consus操作符(::)。
* 右结合

```ocaml
# 1 :: [2; 3; 4];;
- : int list = [1; 2; 3; 4]

(* 右結合 *)
# 1 :: 2 :: [3; 4];;
- : int list = [1; 2; 3; 4]
```

### 列表合并

使用@。

```ocaml
# [] @ [];;
- : 'a list = []
# [1] @ [2; 3];;
- : int list = [1; 2; 3]
# ["asdf"; "hoge"] @ ["fuga"];;
- : string list = ["asdf"; "hoge"; "fuga"]
```

### 模式匹配

match 表达式

match 表达式 with 模式1 - >表达式|模式2 - >表达式...

找到整数列表的总和的例子:

```ocaml
# let rec total l =
    match l with
      [] -> 0
    | h :: rest -> h + (total rest);;
val total : int list -> int = <fun>
# total [1; 2; 3; 4; 5];;
- : int = 15
```
反转列表的函数示例:

```ocaml
# let reverse l =
    let rec innerReverse l1 l2 =
      match l1 with
      | [] -> l2
      | h :: rest -> innerReverse rest (h :: l2)
    in
    innerReverse l [];;
val reverse : 'a list -> 'a list = <fun>
# reverse [1; 2; 3; 4];;
- : int list = [4; 3; 2; 1]
```

### function 表达式

fun 和 match 通过组合定义一个匿名函数

function 模式1 - >表达式|模式2 - >表达式...

上面整数列表的总和的例子可以改写如下：

当使用最后一个参数进行模式匹配时方便，并且该参数仅用于模式匹配

```ocaml
# let rec total = function
    [] -> 0
  | h :: rest -> h + (total rest);;
val total : int list -> int = <fun>
# total [1; 2; 3; 4; 5];;
- : int = 15
```

### map 函数的例子

```ocaml
# let rec map fn = function
    | [] -> []
    | h :: rest -> fn h :: map fn rest;;
val map : ('a -> 'b) -> 'a list -> 'b list = <fun>
# map (fun x -> x + 1) [1; 2; 3; 4];;
- : int list = [2; 3; 4; 5]
```
### fold (折叠)函数例子

```ocaml
(* 左fold *)
# let rec foldl fn acc l =
    match l with
    | [] -> acc
    | h :: rest -> foldl fn (fn acc h) rest;;

(* 用于查找列表长度的 fold 示例 *)
# foldl (fun acc x -> acc + 1) 0 [1; 2; 3];;
- : int = 3

(* 右fold *)
# let rec foldr fn l acc =
    match l with
    | [] -> acc
    | h :: rest -> fn h (foldr fn rest acc);;
val foldr : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b = <fun>
```

### 模式匹配守卫子句

match 表达式 with 模式1 when 真/假表达式 - >表达式| ...

使用 when。

### 注意：match，function 中没有关闭符号

在match with 和 function 上没有结束符号。

因此，当模式匹配嵌套时，必须用（）等括起来

### 数据结构

#### 记录（record）

C语言结构，数据结构等同于Python字典。

命名元素名称。

#### 记录定义

* type name = {field name：type; ...}
* 字段 - >名称和值对
* 请注意，字段名称不能与其他记录重复

```ocaml
# type student = {name: string; id: int};;
type student = { name : string; id : int; }
```
#### 创建记录

* {Field name = value; ...}

```ocaml
# let s = {name = "hoge"; id = 1};;
val s : student = {name = "hoge"; id = 1}
```

### 记录转移

创建一个新的记录值，而不是覆盖现有的值。

{记录 with 字段名称 = 值; ...}

```ocaml
# let s2 = {s with name = "fuga"};;
val s2 : student = {name = "fuga"; id = 1}
```
### 变体

数据结构代表案例分类。 

```ocaml
type name =
  | 构造函数 [ of <type> [* <type>]... ]
  | 构造函数 [ of <type> [* <type>]... ]
  | ...
```
* 构造函数以英文大写字母开头
* of 是构造函数所需的参数类型
* of int * int 参数不是一组int，两个int
* of (int * int) 参数是一对int

以下是四种数字的变体类型：

```ocaml
# type figure =
  | Point
  | Circle of int
  | Rectangle of int * int (* 两个int类型的参数，不是元组 *)
  | Square of int;;
type figure = Point | Circle of int | Rectangle of int * int | Square of int

# let c = Circle 4;;
val c : figure = Circle 4
# let figs = [Point; Rectangle (1, 1); c];;
val figs : figure list = [Point; Rectangle (1, 1); Circle 4]
```

### 变体的模式匹配

#### function | 构造函数的参数 -> | ...

省略参数部分意味着没有参数构造函数。

```ocaml
(* 计算图形面积的例子 *)
# let area = function
  | Point -> 0
  | Circle r -> r * r * 3
  | Rectangle (x, y) -> x * y
  | Square x -> x * x;;
val area : figure -> int = <fun>
# area c;;
- : int = 48
```

