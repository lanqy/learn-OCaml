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
