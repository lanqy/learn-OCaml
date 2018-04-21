# OCaml的模块（结构）和模块类型（签名）

### 隐藏式签名

- 例如，```Stack``` 考虑如下实现一个（纯函数式）堆栈列表。

```ocaml
module Stack0 = struct
  type 'a t = 'a list
  let create () = [] 
  let push x s = x::s (* push x s 将值 x 推入堆栈 s *)
  let pop = function  
    | x::xs -> (x, xs)
    | [] -> failwith "Empty stack"
end
```

- 该模块在外部看起来是一个具有以下签名（模块接口）的模块

```ocaml
module Stack0 : sig
  type 'a t = 'a list
  val create : unit -> 'a list
  val push : 'a -> 'a list -> 'a list
  val pop : 'a list -> 'a * 'a list
end
```
