## OCaml简介第5部分

### 面向对象的功能

#### 类声明

object ... end 

OCaml实例变量的所有成员都是私有的

```ocaml
# class point ini_x ini_y =
    object (self)  (* 自身の名前をつける, 自由なので this とかでも良い *)
      val mutable x = 0 (* 实例变量不能从外部访问 *)
      val mutable y = 0

      (*
       * 实例方法
       * method 方法名称 参数... = 表达式
       *)
      method set new_x new_y = begin x <- new_x; y <- new_y end
      method private print_x = print_int x (* 私有方法 *)

      (* 构造函数 *)
      initializer begin
        x <- ini_x; y <- ini_y
      end
    end;;
(* 签名 *)    
class point :
  int ->
  int ->
  object
    val mutable x : int
    val mutable y : int
    method private print_x : unit
    method set : int -> int -> unit
  end
```
