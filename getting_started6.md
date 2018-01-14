
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
