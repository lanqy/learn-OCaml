
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
包含参数（）是可选的。

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

### 递归定义

#### 用 let rec 定义。

* 使用 rec 可以引用函数定义中定义的函数名称。

阶乘的例子:

```ocaml
# let rec fact x =
    if x <= 1 then 1 else x * fact (x - 1);;
val fact : int -> int = <fun>
# fact 5;;
- : int = 120
```

### 相互递归

* 两个或多个函数相互调用的样式的递归定义。

* let rec 函数名称1 参数1 = 表达式1 and 函数名称2 参数2 = 表达式2 and ...

```ocaml
# let rec even n =
    match n with
    | 0 -> true
    | x -> odd (x-1)
  and odd n =
    match n with
    | 0 -> false
    | x -> even (x-1);;
val even : int -> bool = <fun>
val odd : int -> bool = <fun>

# even 10;;
- : bool = true
# even 3;;
- : bool = false
# odd 3;;
- : bool = true
# odd 10;;
- : bool = false
```

### 匿名函数

#### fun 参数名 = 表达式
* let f 参数 = 表达式 是 let f = fun 参数 = 表达式 的语法糖
* 因为 fun 是尽可能地认识到它是一个函数定义，所以最好在必要时用（）分割它。

### 高阶函数

定义一个函数作为参数

```ocaml
# let twice f x = f (f x);;
val twice : ('a -> 'a) -> 'a -> 'a = <fun>
# twice (fun x -> x * x) 3;;
- : int = 81

# let fourth x = 
    let square y = y * y in
    twice square x;;
val fourth : int -> int = <fun>
# fourth 3;;
- : int = 81
```

### 柯里化函数

```ocaml
# let concat_curry s1 = fun s2 -> s1 ^ s2 ^ s1;;
val concat_curry : string -> string -> string = <fun>
# concat_curry "a";;  (* 部分適用 *)
- : string -> string = <fun>
# (concat_curry "a") "b";;
- : string = "aba"
```

### 柯里化语法糖

一下这个定义
```ocaml
let concat_curry s1 s2 = s1 ^ s2 ^ s1;;
```

与以下相同

```ocaml
let concat_curry s1 = fun s2 -> s1 ^ s2 ^ s1;;
```

也就是说，当参数排序的时候，以下代码

```ocaml
# let fuga x y z = x + y + z;;
val fuga : int -> int -> int -> int = <fun>
```

实际上可以展开为以下代码

```ocaml
# let hoge x = fun y -> fun z -> x + y + z;;
val hoge : int -> int -> int -> int = <fun>
```

函数是左结合，所以可以扩展如下：

```ocaml
f x y z => (((f x) y) z)
```

函数类型构造函数是右结合的

```ocaml
int - > int - > int - > int = <fun>
解释为
int - >（int - >（int - > int））= <fun>
```
