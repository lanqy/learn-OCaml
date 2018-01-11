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
#### 实例生成

new 类名称

```ocaml
# let p = new point;;
val p : point = <obj>
```

#### 调用实例方法

实例#方法名称

```ocaml
# p#set 1 2;;
- : unit = ()
```

#### 継承

inherit 类名

以下类可以由 self 本身通过 super 访问父类。

```ocaml
(* 打印坐标 *)
# class point_with_print x y =
    object (self)
      inherit point x y as super (* 访问父类的名称 *)
      method print = Printf.printf "(%d, %d)\n" x y
    end;;
class point_with_print :
  int ->
  int ->
  object
    val mutable x : int
    val mutable y : int
    method print : unit
    method private print_x : unit
    method set : int -> int -> unit
  end

(* 生成继承类的实例 *)
# let p = new point_with_print 1 1;;
val p : point_with_print = <obj>
# p#print;;
(1, 1)
- : unit = ()
```

#### 类类型

##### <方法名称：类型 ...>

* 对象的类型是方法类型的顺序

* 如果方法名称和类型的组合匹配，则认为是相同的对象类型

* 要检查一个类的类型，直接使用 let 定义对象而不使用 class。

```ocaml
(* 直接定义对象 *)
let obj = 
  object (self)
    val mutable x = 0
    val mutable y = 0
    method set new_x new_y = begin x <- new_x; y <- new_y end
  end;;

(* 显示类型 *)
val obj : < set : int -> int -> unit > = <obj>
(* 尝试调用实例方法 *)
# obj#set 1 2;;
- : unit = ()
```

#### 上面的 obj 类型是 < set : int -> int -> unit >

换句话说，这意味着有一个方法设置int - > int - > unit。

具有满足这个定义的方法的类被认为是相同的对象类型。

```ocaml
(* 定义上面与obj无关的类 *)
# class unrelated_class =
    object
      (* 定义一个显示x，y的方法集 *)
      method set x y = Printf.printf "(%d, %d)\n" x y
    end;;
class unrelated_class : object method set : int -> int -> unit end

(* 由于对象类型匹配，它们被放在同一个列表中 *)
# let obj2 = new unrelated_class;;
val obj2 : unrelated_class = <obj>
# [obj; obj2];;
- : unrelated_class list = [<obj>; <obj>]

(* 由于对象类型匹配，可以将其作为相同的返回值类型进行处理 *)
# let hoge x = if x then obj else new unrelated_class;;
val hoge : bool -> unrelated_class = <fun>
# (hoge true)#set 1 2;;
- : unit = ()
# (hoge false)#set 1 2;;
(1, 2)
- : unit = ()
```

我个人觉得Java和Go的界面正在扮演OCaml的对象类型的角色。

#### 部分类型

##### 部分类型=>如果定义了部分对象类型的方法，则将其视为部分类型

* 示例：类型2是类型1的部分类型

* 类型1 => <方法1：int - > int，方法2：unit>

* 类型2 => <method1：int - > int>

#### CORATION（类型转换）

（表达式：类型1：>类型2）

将部分类型1转换为类型2。 它接近于Java中的上传。

```ocaml
(* print_class1 是 print_class2 的部分类型 *)
# class print_class1 = object
    method print_1 = print_int 1
  end;;
class print_class1 : object method print_1 : unit end
# class print_class2 = object
    method print_1 = print_int 1
    method print_2 = print_int 2
  end;;
class print_class2 : object method print_1 : unit method print_2 : unit end

(* 由于对象类型不同，print_class 1和print_class 2不在同一个列表中 *)
# let obj_list = [new print_class1; new print_class2];;
Error: This expression has type print_class2
       but an expression was expected of type print_class1
       The second object type has no method print_2

(* 通过指导（类型转换）把它们放在同一个列表中 *)
# let obj_list = [new print_class1; (new print_class2 :> print_class1)];;
val obj_list : print_class1 list = [<obj>; <obj>]

(* コアーションによって削ぎ落とされた情報は呼び出せない *)
# let [obj1; obj2] = obj_list;;
val obj1 : print_class1 = <obj>
val obj2 : print_class1 = <obj>

# obj1#print_1;; (* 可以调用 *)
1- : unit = ()
# obj2#print_2;; (* 不能被调用 *)
Error: This expression has type print_class1
       It has no method print_2
```

#### 多层对象类型

表示满足部分类型的任意类型

* <方法名称1：类型1; ...，方法名称n：类型n; ..>

 * 最后一个“..”是重要的

 * 换句话说，它表示“各种其他”
 
 ```ocaml
 
 (* 定义接受多层对象类型的函数 *)
# let print1 print_obj = print_obj#print_1;;
val print1 : < print_1 : 'a; .. > -> 'a = <fun>

(* 您可以接收满足部分类型的对象类型 *)
# print1 obj1;;
1- : unit = ()
# print1 obj2;;
1- : unit = ()
```
