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

- 这个模块有问题，类型 ``` 'a Stack0.t ``` 把 ``` 'a list ``` 暴露在外面，用户将能够打破模块化，例如，通过 ``` push ```
为了解决这个问题，我们使用模块的签名来隐藏 Stack.t 类型。首先，用模块类型声明定义堆栈模块签名 STACK

```ocaml
module type STACK = sig
  type 'a t
  val create : unit -> 'a t
  val push : 'a -> 'a t -> 'a t
  val pop : 'a t -> 'a, 'a t
end
```

- 签名是一种模块，可以说是一种指定模块的功能和类型如何从外部看的方式。将来我们会称之为签名或模块类型
接下来，用STACK限制堆栈模块的类型。
```ocaml
module Stack : STACK (* 隐藏 *) = struct
  type 'a t = 'a list
  let create () = []
  let push x s = x::s
  let pop = function
    | x::xs -> x, xs
    | [] -> failwith "Empty stack"
end

(* 或 *)
module Stack : STACK = Stack0
```
