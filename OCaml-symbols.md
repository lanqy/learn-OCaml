
## OCaml 符号

##### 1、 ```(* ... *) ```

- 标识注释，例如：
 
```ocaml
 (** Bump the frequency count for the given string. *)
val touch : (string * int) list -> string -> (string * int) list
```

##### 2、 ```[ ... ] ```

- 生成一个列表（类型）。 使用 ; 分隔符列表元素，例如：

```ocaml
# let words = ["foo"; "bar"; "baz"];;
val words : string list = ["foo"; "bar"; "baz"]
```

##### 3、 ``` ,```

- 生成一个元组。但是，元组的类型是通过 ``` * ``` 号来分隔每个元素的，例如：

```ocaml
(* 类型定义 *)
type name = string * string

(* 元组生成 *)
let johndoe = ("John", "Doe")

(* 模式匹配 *)
match s with
| (first, last) -> Printf.printf "my name is %s %s" first last
```
