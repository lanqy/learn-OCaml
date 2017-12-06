## Ocaml 语法

### Ocaml 语法

### 基础
| 代码  | 描述 |
|---|---|
|<tt>(* ... *)</tt>|注释 (可嵌套)|
|<tt>&lt; &gt; &lt;= &gt;=</tt>|对比|
|<tt>min / max</tt>|对比 (最小 / 最大 (二进制 或者 更多))|
|<tt>compare</tt>|对比 (返回三个值 (即： 小于,等于或者大于))|
|<tt>(** ... *)</tt>|文档注释|
|<tt>= &lt;&gt;</tt>|等于 / 不等于 (深比较)|
|<tt>== !=</tt>|等于 / 不等于 (浅比较)|
|<tt>Gc.full_major()</tt>|强制垃圾回收|
|<tt>( ... )</tt>|分组表达式|
|<tt>begin ... end</tt>|分组表达式|
|<tt>case-sensitive</tt>|tokens（区分大小写（关键字，变量标识符...））|
|<tt>[_A-Z][_a-zA-Z0-9']*</tt>|tokens（常量正则（如果与变量标识符正则不同））|
|<tt>[_a-z][_a-zA-Z0-9']*</tt>|tokens （类型正则（如果不同于变量标识符正则表达式））|
|<tt>[_a-z][_a-zA-Z0-9']*</tt>|tokens （变量标识符正则表达式）|
|<tt>&lt;-</tt>|变量赋值或声明（赋值）|
|<tt>let v = e in</tt>|变量赋值或声明（声明）|

### 函数
| 代码  | 描述 |
|---|---|
|<tt>fun a b -&gt; ...</tt>|匿名函数|
|<tt>f a b ...</tt>|函数调用（ a 和 b 为参数）|
|<tt>f()</tt>|函数调用（无参数）|
|<tt>let f para1 para2 = ...</tt>|函数定义|
|<tt>no syntax needed</tt>|函数返回值（函数体就是函数的返回值）|

### 控制流

| 代码  | 描述 |
|---|---|
|<tt>try a with exn -&gt; ...</tt>|异常捕获|
|<tt>raise</tt>|抛出异常|
|<tt>if c then ...</tt>|if_then|
|<tt>if c then b1 else b2</tt>|if_then_else|
|<tt>for i = 10 downto 1 do ... done</tt>|循环（对于数值范围中的每个值，减1）|
|<tt>for i = 1 to 10 do ... done</tt>|循环（对于数值范围中的每个值，加1 ）|
|<tt>while c do ... done</tt>|循环 (循环满足某个条件做某事)|
|<tt><pre>match val with
 | v1 -&gt; ...
 | v2 | v3 -&gt; ...
 | _ -&gt; ...</pre></tt>|模式匹配|
|<tt>;</tt>|序列|
