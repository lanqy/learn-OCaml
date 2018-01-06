
# OCaml简介第1部分

## 基本类型

### 整型（int）
#### 字首
* 二进制 0b
* 八进制 Oo
* 十六进制 0x

```ocaml
# 351;;
- : int = 351
# 12345;;
- : int = 12345
# 0o523;;
- : int = 339
# 0xffff;;
- : int = 65535
```

### 浮点数（float）

```ocaml
# 3.141;;
- : float = 3.1415
# 1.04e10;;
- : float = 10400000000.
# 25e-15;;
- : float = 2.5e-14
```

### 字符（char）

* 将其用单引号括起来，用单字节字母数字字符（ascii字符）

```ocaml
# 'a';;
- : char = 'a'
# '\101';;
- : char = 'e'
# '\n';;
- : char = '\n'
```

### 字符串（string）

* 用双引号括起来。
* 一个字符串，一个字符可以用[下标]获取。

```ocaml
# "string";;
- : string = "string"
# "string".[0];;
- : char = 's'
```
### 类型转换

* 从X类型转换为Y类型的函数的命名规则为Y_of_X。

```ocaml
# float_of_int 5;;
- : float = 5.
# int_of_float 5.;;
- : int = 5
- # string_of_int 123;;
- : string = "123"
# int_of_string "123";;
- : int = 123
```

### 元组

* (类型名 * 类型名...)

```ocaml
# (1, 2);;
- : int * int = (1, 2)
# ('a', 1, "str", 4.3);;
- : char * int * string * float = ('a', 1, "str", 4.3)
# ((1, 2), ('a', "str"));;
- : (int * int) * (char * string) = ((1, 2), ('a', "str"))
```
### 定义变量

#### let 定义（let defenition）

* let 变量名称 = 表达式

```ocaml
# let hoge = 1;;
val hoge : int = 1
```
#### 可以同时定义

* let 变量名称 = 表达式1 and 表达式2

```ocaml
# let a = 1 and b = 2;;
val a : int = 1
val b : int = 2
```

### 定义函数

#### let 函数名 参数 = 表达式
```ocaml
# let twice s = s ^ s;; 
val twice : string -> string = <fun>
```
* 包含参数（）是可选的。

#### let 表达式（let expression）

* 与 let 定义不同。
* 用于在函数中定义临时变量（局部变量）的表达式。
* let 变量名 = 表达式1 in 表达式2

```ocaml
# let four_times s =
  let twice = s ^ s in
  twice ^ twice;;
val four_times : string -> string = <fun>
```

