### Ocaml 语法

### 

| <tt>nothing needed</tt> | breaking lines (useful when end-of-line and/or indentation has a special meaning)  | 
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
|<tt>[_A-Z][_a-zA-Z0-9']*</tt>|tokens (constant regexp (if different from variable identifier regexp))|
|<tt>[_a-z][_a-zA-Z0-9']*</tt>|tokens (type regexp (if different from variable identifier regexp))|
|<tt>[_a-z][_a-zA-Z0-9']*</tt>|tokens (variable identifier regexp)|
|<tt>underscores for functions / types, unclear for modules / constructors</tt>|tokens (what is the standard way for <a href="http://c2.com/cgi/wiki?CapitalizationRules">scrunching together multiple words</a>)|
|<tt>&lt;-</tt>|variable assignment or declaration (assignment)|
|<tt>let v = e in</tt>|variable assignment or declaration (declaration)|
