
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

