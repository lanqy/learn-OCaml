## OCaml简介第4部分

### 模块

它是程序的一部分，但在OCaml中被称为结构。

所有OCaml库都作为模块（结构）提供。

#### 文件名称是模块名称

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

