
## OCaml 符号

##### 1、(* ... *) 

- 标识注释，例如：
 
```ocaml
 (** Bump the frequency count for the given string. *)
val touch : (string * int) list -> string -> (string * int) list
```

##### 2、[ ... ] 

- 生成一个列表（类型）。 使用 ; 分隔符列表元素，例如：

```ocaml
# let words = ["foo"; "bar"; "baz"];;
val words : string list = ["foo"; "bar"; "baz"]
```
