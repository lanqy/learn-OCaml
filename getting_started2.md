## OCaml简介第2部分

### 递归多层数据结构。
* 列表类型
```ocaml
# [1;2;3;4;5];;
- : int list = [1; 2; 3; 4; 5]
# ["a"; "b"; "c"];;
- : string list = ["a"; "b"; "c"]

(* 不同的类型不能存在于同一个列表 *)
# [1; "a"];;
Error: This expression has type string but an expression was expected of type int
```

