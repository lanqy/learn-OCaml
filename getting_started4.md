## OCaml简介第4部分

### 模块

它是程序的一部分，但在OCaml中被称为结构。

所有OCaml库都作为模块（结构）提供。

#### 文件名称即是模块名称

文件名 example.ml => 模块名称为 Example

#### 标准模块

OCaml 内置模块

```ocaml
(* 列表 *)
# List.length [1; 2; 3];;
- : int = 3
# let q = Queue.create ();;
val q : '_a Queue.t = <abstr>

(* 队列 *)
# Queue.add "first" q;;
- : unit = ()
# Queue.take q;;
- : string = "first"
# Queue.take q;;
Exception: Queue.Empty.

(* 数组 *)
# Array.make 3 'a';;
- : char array = [|'a'; 'a'; 'a'|]

(* 标准输出 *)
# Printf.printf "%d, %x, %s\n" 10 255 "hoge";;
10, ff, hoge
- : unit = ()
```
#### open 模块

通过 open 打开模块可以省略模块名称

与 python 中 from hoge import * 类似

由于打开到当前源的模块的名称空间已扩展，因此只有在不困惑时才能打开它。

由于容器名称经常与函数名称重叠，因此不打开它们是正常的。

```ocaml
(* 打开模块 *)
# open List;;
# length [1; 2; 3];;
- : int = 3

(* 覆盖函数名称 *)
# let length () = "overload!";;
val length : unit -> string = <fun>
# length ();;
- : string = "overload!"

(* 您可以通过指定模块名称来调用它 *)
# List.length [1; 2; 3];;
- : int = 3
```
顺便说一下，OCaml有一个名为Pervasives的模块，在启动时打开。

像abs和open_in这样的函数属于这个模块。

#### 模块定义

模块名称以大写字母开头

##### module 模块名 = struct 各种定义... end

```ocaml
(* 模块定义 *)
# module Hello = struct
    let message = "Hello"
    let hello () = print_endline message
  end;;
module Hello : sig val message : string val hello : unit -> unit end
(* 调用 *)
# Hello.hello ();;
Hello
- : unit = ()
```