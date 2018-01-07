## OCaml简介第3部分

### 异常处理

它在您除以零或指定一个不存在的文件时发生。

```ocaml
# 1/0;;
Exception: Division_by_zero.
# open_in "";;
Exception: Sys_error ": No such file or directory".
```
#### 抛出异常（ raise 表达式 ）

##### raise 异常
##### raise（ 异常参数 ）

如果异常需要参数，则（）是必需的。

```ocaml
# raise Not_found;;
Exception: Not_found.
# raise (Sys_error ": No such file or directory");;
Exception: Sys_error ": No such file or directory".
# raise (Sys_error ": 我会抛出异常！");;
Exception: Sys_error ": ?\136\145?\154?\138\155?\135??\130常?\129".
```

```ocaml
# let rec fact n =
    if n < 0 then raise (Invalid_argument ": negative argument")
    else if n = 0 then 1 else n * fact (n-1);;
val fact : int -> int = <fun>
# fact 5;;
- : int = 120
# fact (-1);;
Exception: Invalid_argument ": negative argument".
```

#### 异常处理( try with )

##### try 表达式 with 异常1 -> 表达式1 | ...

```ocaml
# try raise Not_found with
  | Not_found -> "not found !"
  | _ -> "unknown !";;
- : string = "not found !"

(* 前面定义的 fact 函数例子 *)
# try fact (-1) with
  | Invalid_argument _ -> 0
  | _ -> 9999;;
- : int = 0
```
#### 异常定义

异常类型的构造函数中称为异常构造函数。
该变种是 exn 类型

```ocaml
(* 确认异常的变体类型 *)
# Not_found;;
- : exn = Not_found
# raise;;
- : exn -> 'a = <fun>
```

异常定义是为exn类型添加一个新的构造函数。

exn类型是特殊的，你可以稍后添加一个构造函数。

##### exception 异常名

```ocaml
(* 异常定义 *)
# exception Hoge;;
exception Hoge
# exception Fuga of string;;
exception Fuga of string
# raise Hoge;;
Exception: Hoge.
# raise (Fuga "fuga!");;
Exception: Fuga "fuga!".
```

#### 关于exn类型

既然exn也是一个变体类型，它也可以作为一个参数传递。

```ocaml
# exception Hoge;;
exception Hoge

(* exn 类型列表 *)
# let exnlist = [Not_found; Hoge; (Invalid_argument "fuga")];;
val exnlist : exn list = [Not_found; Hoge; Invalid_argument "fuga"]

(* 接收exn类型的函数 *)
# let f = function
  | Hoge -> "hoge!"
  | x -> raise x;;
val f : exn -> string = <fun>
# f Hoge;;
- : string = "hoge!"
# f Not_found;;
Exception: Not_found.
```
### unit 类型

输出字符串的程序。

```ocaml
# print_string "hoge\n";;
hoge
- : unit = ()
```
返回类型是 unit 类型

unit 类型的值只是一个名为（）的常量，称为 unit 值。

#### unit 类型的用法

* （）上没有可以执行的操作
* 用作返回值本身没有意义的函数的返回值
* 在定义不需要有意义的参数的函数时用作参数

```ocaml
# let const () = 777;;
val const : unit -> int = <fun>
# const ();;
- : int = 777
```

##### 用作判断操作是否成功的返回值

```ocaml
（*
   () 将匹配模式，如果操作成功，将返回单位类型。
   也就是说，如果匹配成功，则表示操作成功。
*）
# let () = Bytes.set "Test" 1 'C';;
```

### 可变的数据结构

#### 修改字符串

##### "string".[index] <- 'char'

```ocaml
# let s = "life";;
val s : string = "life"
# s.[2] <- 'v';;
- : unit = ()
# s;;
- : string = "live"

(* String.set 弃用 *)
# let f2 = "hoge";;
val f2 : string = "hoge"
# Bytes.set f2 0 'H';;
- : unit = ()
# f2;;
- : string = "Hoge"
```

##### 该操作操作参考目的地 

```ocaml
# let s = "hoge";;
val s : string = "hoge"
# let a = (s, s);;
val a : string * string = ("hoge", "hoge")
# Bytes.set s 3 'E';;
- : unit = ()

(* 两者都被改变，因为参考目标是相同的 *)
# a;;
- : string * string = ("hogE", "hogE")
```

#### 物理相等

##### 物理相等 => 比较数据地址时的平等性

* 使用 ==, !=

##### 结构相等 => 平等作为价值进行比较

* 使用=，<>

```ocaml
# let s1 = "hoge" and s2 = "hoge";;
val s1 : string = "hoge"
val s2 : string = "hoge"
(* 结构相等 *)
# s1 = s2;;
- : bool = true
(* 物理相等 *)
# s1 == s2;;
- : bool = false
# s1 != s2;;
- : bool = true
```
#### 可修改的记录

* 修改记录 => 使用 mutable 关键字

* 记录修改 => record.field <- 值

```ocaml
# type account = {name:string;mutable amount:int};;
type account = { name : string; mutable amount : int; }
# let ac = {name = "bob"; amount = 1000};;
val ac : account = {name = "bob"; amount = 1000}
# ac.amount <- 999;;
- : unit = ()
# ac;;
- : account = {name = "bob"; amount = 999}

(* 不可改变 *)
# let () = ac.name <- "Hoge";;
Error: The record field name is not mutable
(* 这样是可以的 *)
# ac.name.[0] <- 'B';;
- : unit = ()
# ac;;
- : account = {name = "Bob"; amount = 999}
```
