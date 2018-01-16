## OCaml简介第6部分


### 标记的参数
#### 〜标签名称：

* 你可以命名这个参数。

* 如果你给一个标签名称，你可以改变你喜欢的参数的顺序。

```ocaml
(* 使用带标签的参数定义函数 *)

# let rec range ~first: a  ~last: b = 
  if a > b then []
  else a :: range ~first: (a + 1) ~last: b;;
  
(* 函数类型上的标签类型 *)
val range : first:int -> last:int -> int list = <fun>

(* 指定标签名称函数应用程序 *)

# range ~first: 1 ~last: 10;;

- : int list = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10] 

# range ~last: 10 ~first: 1;;

- : int list = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10] 

(* 除非指定了标签名称，否则按标签名称定义应用 *) 

# range 1 10;;
- : int list = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]

# range 10 1;;
- : int list = []
```

* 〜hoge：○○ ○○ 是可选的

```ocaml
# let rec range ~first ~last = 
  if first > last then []
  else first :: range (first + 1) last;;
val range : first:int -> last:int -> int list = <fun>
```

#### 可选参数

?标签名称：（pattern =表达式）

与Python的家伙相同的功能。

```ocaml
(* 默认值1给出步骤值 *)

# let rec range ?(step = 1) a b = 
  if a > b then []
  else a :: range ~step (a + step) b;;
val range : ?step:int -> int -> int -> int list = <fun>

(* 函数应用 *)
# range 1 10;;

- : int list = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]

(* 因为它在调用时指定了标签 *)

# range 1 10 ~step:2;;
- : int list = [1; 3; 5; 7; 9]
# range 1 ~step:3 10;;
- : int list = [1; 4; 7; 10]

# range 2 1 10;;
Error: The function applied to this argument has type ?step:int -> int list
This argument cannot be applied without label
```
#### 关于可选参数的说明

##### 在选项参数后面准备一个无标签的参数

如果选项参数在函数的结尾，则它变成了不能省略的选项参数，所以没有任何意义。

```ocaml
(**
 * 我想定义一个函数，返回常量1 ....。
 * 如果选项参数在最后，我会收到警告
 *)
# let f ?(x=1) = x;;
Warning 16: this optional argument cannot be erased.
val f : ?x:int -> int = <fun>
(* 1函数返回我以为它返回一个函数，接收*选项参数返回正在currying
 *)
# f;;
- : ?x:int -> int = <fun>

(* 最后这么糟糕，不要添加无标签的参数 *)
# let f ?(x=1) () = x;;
val f : ?x:int -> unit -> int = <fun>
# f;;
- : ?x:int -> unit -> int = <fun>
# f();;
- : int = 1
```
#### 选项参数实体

可选参数是用 'a option 实现的

如果你没有指定默认值，并写入它，尝试执行，你会得到一个错误，如下所示

```ocaml
# let rec range ?step a b =
    if a > b then []
    else a :: range ~step (a+step) b;;
(* 'a option type error is occurring  *)
Error: This expression has type 'a option
       but an expression was expected of type 'a
       The type variable 'a occurs inside 'a option
```

因此，在这种情况下，None 加 'a Some 来模式匹配

```ocaml

(* 与选项类型匹配的模式 *)

# let rec range ?step a b =
    let s = match step with None -> 1 | Some s -> s in
    if a > b then [] else a :: range (a + s) b;;
val range : ?step:int -> int -> int -> int list = <fun>

# range 1 10;;
- : int list = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10]
```

#### 多态变种

##### `Constructor

一种机制，可以为多种变体类型使用通用的构造函数。

消除 “1构造函数<=> 1变体” 的限制。

```ocaml
# `Hoge;;
- : [> `Hoge ] = `Hoge
# `Hoge 2;;
- : [> `Hoge of int ] = `Hoge 2
# `Hoge `Fuga;;
- : [> `Hoge of [> `Fuga ] ] = `Hoge `Fuga
```

#### 函数返回多态变种

```ocaml
# let f b = if b then `Hoge else `Fuga;;
val f : bool -> [> `Fuga | `Hoge ] = <fun>
```
```ocaml
# let hoge = function
  | `Hoge -> "hoge"
  | `Fuga -> "fuga"
  | `Piyo -> "piyo";;
val hoge : [< `Fuga | `Hoge | `Piyo ] -> string = <fun>
```

#### 多态变种的类型方案

[> ...] , [<...] 是类型方案 (同 `a)

[> ..] 和 [< ..] 它被视为有限制的类型变量。

在 [> ...] 的情况下
[> 可以解释为 “包含多态变种” 或更高。

```ocaml
(* 
 * 可以接受任何东西的多相变体列表
 *)
# let  a : [>] list = [`Fuga; `Piyo];;
val a : [> `Fuga | `Piyo ] list = [`Fuga; `Piyo]

# a @ [`Asdf];;
- : [> `Asdf | `Fuga | `Piyo ] list = [`Fuga; `Piyo; `Asdf]
```
