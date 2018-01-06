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
