# OCaml 速成

[OCaml](https://ocaml.org/) 是 [ReasonML](https://reasonml.github.io/) 的基础，它作为一种领先的编译器到 JS 语言已经引起了大量的热议，今天在 Jane Street 提供了一个免费的 OCaml 研讨会，所以我决定在这里分享我的笔记。多年来，Jane Street 一直运行着数十亿美元的 OCaml 代码库，因此它们是非常可靠的专业知识来源。


公平的警告：这篇文章不像一个正常的 Dev.To 文章，因为这是一个研讨会的指导漫游 - 你需要编码，否则这对你来说是完全没用的。但是，通过这 24 个示例（大约需要 2-3 个小时），您应该对 OCaml 中的关键语言特性有深刻的了解！

一个免责声明：我有使用 Haskell 的经验，所以我可能会在这里使用静态类型化/函数式语言的一些无意识的知识。

- [在您的系统上安装 OCaml](https://github.com/lanqy/learn-OCaml/blob/master/ocaml-speedrun.md#在您的系统上安装ocaml)
- [基础知识](https://github.com/lanqy/learn-OCaml/blob/master/ocaml-speedrun.md#基础知识)
- [快速预览](https://github.com/lanqy/learn-OCaml/blob/master/ocaml-speedrun.md#快速预览)
- [Hello World：/ 01-介绍](https://github.com/lanqy/learn-OCaml/blob/master/ocaml-speedrun.md#Hello-World：/ 01-介绍)
- [基本数据类型：/ 02-basic_types](https://github.com/lanqy/learn-OCaml/blob/master/ocaml-speedrun.md#基本数据类型：/ 02-basic_types)
- 定义函数：/ 03-define_functions
- 调用函数：/ 04-call_functions
- 函数作为参数：/ 05-两次
- 模式匹配：/ 06模式匹配
- 递归：/ 07-simple_recursion
- 数据类型：链接列表：/ 08-list_intro
- 建筑清单：/ 09-list_range
- 通过列表递归：/ 10-list_product
- 抽象函数：/ 11-sum_product
- 浮点函数：/ 12-list_min
- 抽象和浮点函数：/ 13-largest_smallest
- 数据类型：变体类型又名枚举/ 14变体
- 数据类型：元组和参数化类型/ 15元组
- 标记的参数/ 16-labelled_arguments
- 数据类型：选项/ 17选项
- 匿名函数/ 18-anonymous_functions
- 列表操作/ 19-list_operations
- 类型定义！ / 20-reading_sigs
- 折叠心/ 21-writing_list_operations
- 数据类型：不可变记录/ 22条记录
- 数据类型：可变记录/ 23-mutable_records
- 数据类型：refs / 24-refs
- 这是所有的谎言！
- 额外的知识

# 在您的系统上安装OCaml

按照这个：[https：//github.com/janestreet/install-ocaml](https：//github.com/janestreet/install-ocaml)。按照这些说明，我们没有任何问题。我在VS Code中为“开发IDE”扩展了我的开发环境，但 vim / emacs 也得到了很好的支持。Sublime 尚未支持。

# 基础知识

[opam](https://opam.ocaml.org/) 是 OCaml 的包管理器。如果您按照上述说明操作，您已经使用过它。

作为上述过程的一部分，您还会安装Jane Street推荐的 utop ，作为比默认更好的“顶层”。 “顶层”也被称为 [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)。

[merlin](https://github.com/ocaml/merlin) 是用于编译/语法突出显示/代码完成的引擎。

我们不使用 “原始 OCaml” - 我们正在使用 Jane Street 的 [Base](https://opensource.janestreet.com/) 类库，它覆盖了OCaml 的 stdlib ( 标准库 ) 和他们的一些意见。这就是你将在所有问题集的第一行看到的内容：

```ocaml
open! Base
```

模块导入都是这样完成的。稍后我们会看到更多。

# 快速预览

`git clone https://github.com/janestreet/learn-ocaml-workshop`

打开 `/02-exercises` 目录。我们将要经历所有这些！

# Hello World：/ 01-介绍

正如它在 problem.ml 中所说的，只需运行 jbuilder runtest 即可看到错误：

```ocaml
✝  learn-ocaml-workshop/02-exercises/01-introduction> jbuilder runtest
Entering directory '/Users/swyx/ocaml/learn-ocaml-workshop'
         ppx 02-exercises/01-introduction/problem.pp.ml (exit 1)
(cd _build/default && ./.ppx/ppx_jane/ppx.exe --dump-ast --cookie 'library-name="problem_1"' -o 02-exercises/01-introduction/problem.pp.ml --impl 02-exercises/01-introduction/problem.ml)
File "02-exercises/01-introduction/problem.ml", line 25, characters 22-23:
Error: String literal not terminated
```

所以如果你修复第25行：let () = Stdio.printf "Hello，World!" 通过添加最后一个引号，你会得到

```ocaml
✝  learn-ocaml-workshop/02-exercises/01-introduction> jbuilder runtest
Entering directory '/Users/swyx/ocaml/learn-ocaml-workshop'
         run alias 02-exercises/01-introduction/runtest
Hello, World!
```

欢乐世界！注意运行 jbuilder 时如何添加新的 .merlin 文件 - 这是编译器在工作。

# 基本数据类型：/ 02-basic_types

再次前往 problem.ml ，并给它一个阅读。你的任务是在 65 和 68 行上实现这两个函数：

```ocaml
let int_average x y = failwith "For you to implement"

(* val float_average : float -> float -> float *)
let float_average x y =  failwith "For you to implement"
```
如果您再次运行 jbuilder，则会看到错误，因为这些函数当前使用 “failwith” 实现。是时候真正实现了！

注意类型签名被注释掉了。该文件夹也有一个 problem.mli 文件。这个文件声明了关联文件的接口，并且恰好有你需要的特征，所以我们不需要担心它。

### 解决方案

`int_average` 可以用以下方法解决： `let int_average x y = (x + y) / 2` 这是有道理的。但是 `float_average` 需要特定于浮点的运算符（这与 Haskell 不同），否则您将得到此错误：

```ocaml
File "02-exercises/02-basic_types/problem.ml", line 163, characters 27-29:
Error: This expression has type float but an expression was expected of type
         Base__Int.t = int
```

注意，如果你真的去了第163行，你可以看到产生该错误的测试。您可以使用浮点特定运算符（在第13-15行中提到）来解决此问题：

```ocaml
let float_average x y = (x +. y) /. 2.
```

# 定义函数

这个非常简单。我确实喜欢这个事实

> 在 OCaml 中，字符串之外，空格和换行符是相同的。

### 解决方案

```ocaml
let plus x y = x + y

let times x y = x * y

let minus x y = x - y

let divide x y = x / y

```

# 调用函数

两个数字的平均值相加，然后减半。




```ocaml

let square x = x * x
let half x = x / 2
let add x y = x + y

let average x y = half (add x y)

```

玩弄多行语法和隐式返回，这也是可行的：

```ocaml
let average x y = 
    let res = add x y in
    half res
```

这也是如此：

```ocaml
let average x y = 
    let res = add
        x
        y in
    half
        res
```

# 作为参数的函数

我觉得作为一流公民的职能到处都是很好的接受概念。

### 解决方案

```ocaml
let add1 = x + 1
let square x = x * x
let twice f x = f (f x)
let add2 = twice add1
let raise_to_the_fourth = twice square
```

# 模式匹配：

另一个来自 [Haskell](https://www.haskell.org/tutorial/patterns.html) 的熟悉模式正在 [Javascript](https://github.com/tc39/proposal-pattern-matching) 中提出。但需要一个特殊的关键字匹配 `_`。

### 解决方案

```ocaml
let non_zero x = 
    match x with
    | 0 -> false
    | _ -> true
```

# 递归

请参阅：递归。递归函数需要用let rec声明

### 解决方案
```ocaml
let rec add_every_number_up_to x = 
（*请确保我们不会将此号码称为负数！*）
 assert (x >= 0);
 match x with
 | x -> 0
 | _ -> x + (add_every_number_up_to (x - 1))

 (* 让我们编写一个函数将每个数字乘以x。记得：[factorial 0] is 1 *)

 let rec factorial x = 
    assert (x >= 0);
    match x with
    | 0 -> 1
    | 1 -> 1
    | _ -> x * (factorial (x - 1))
```

# 数据类型：链接列表

本练习将数组与模式匹配和递归配对。这里棘手的新问题是立即解构你正在匹配的列表，这让我绊倒了一下。但是，如果仔细观察，提供的长度示例是有益的。

### 解决方案

```ocaml
let rec sum lst = 
    match lst with
    | [] -> 0
    | hd :: tl -> hd + (sum(tl))
```

# 创建列表

这又是一个递归的答案。你想使范围函数递归，然后自始至终调用自己，直到等于to_。我最初试过这个：

```ocaml
let rec range from to_ = 
    match from with
    | to_ -> []
    | _ -> (from :: (range (from + 1) to_))
```

这没有效果，因为匹配分配给to_，而不是与恼人的比较。

### 解决方案

 ```ocaml
 let rec range from to_ =
  match from = to_ with
  | true -> []
  | false -> (from :: (range (from + 1) to_))
 ```