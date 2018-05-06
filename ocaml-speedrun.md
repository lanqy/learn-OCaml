# OCaml 速成

[OCaml](https://ocaml.org/) 是 [ReasonML](https://reasonml.github.io/) 的基础，它作为一种领先的编译器到 JS 语言已经引起了大量的热议，今天在 Jane Street 提供了一个免费的 OCaml 研讨会，所以我决定在这里分享我的笔记。多年来，Jane Street 一直运行着数十亿美元的 OCaml 代码库，因此它们是非常可靠的专业知识来源。


公平的警告：这篇文章不像一个正常的 Dev.To 文章，因为这是一个研讨会的指导漫游 - 你需要编码，否则这对你来说是完全没用的。但是，通过这 24 个示例（大约需要 2-3 个小时），您应该对 OCaml 中的关键语言特性有深刻的了解！

一个免责声明：我有使用 Haskell 的经验，所以我可能会在这里使用静态类型化/函数式语言的一些无意识的知识。

- [在您的系统上安装 OCaml](https://github.com/lanqy/learn-OCaml/blob/master/ocaml-speedrun.md#在您的系统上安装ocaml)
- [基础知识](https://github.com/lanqy/learn-OCaml/blob/master/ocaml-speedrun.md#基础知识)
- 穿过车间
- Hello World：/ 01-介绍
- 基本数据类型：/ 02-basic_types
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

# 基础知识