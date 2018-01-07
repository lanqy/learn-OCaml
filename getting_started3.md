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
