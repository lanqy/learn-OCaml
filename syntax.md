# Ocaml syntax

### 
<table border="1" cellpadding="6">
<tbody><tr><td><tt>nothing needed</tt></td><td>breaking lines (useful when end-of-line and/or indentation has a special meaning)</td></tr>
<tr><td><tt>(* ... *)</tt></td><td>注释 (可嵌套)</td></tr>
<tr><td><tt>&lt; &gt; &lt;= &gt;=</tt></td><td>对比</td></tr>
<tr><td><tt>min / max</tt></td><td>对比 (最小 / 最大 (二进制 或者 更多))</td></tr>
<tr><td><tt>compare</tt></td><td>对比 (返回三个值 (即： 小于,等于或者大于))</td></tr>
<tr><td><tt>(** ... *)</tt></td><td>文档注释</td></tr>
<tr><td><tt>= &lt;&gt;</tt></td><td>等于 / 不等于 (深比较)</td></tr>
<tr><td><tt>== !=</tt></td><td>等于 / 不等于 (浅比较)</td></tr>
<tr><td><tt>Gc.full_major()</tt></td><td>force garbage collection</td></tr>
<tr><td><tt>( ... )</tt></td><td>grouping expressions</td></tr>
<tr><td><tt>begin ... end</tt></td><td>grouping expressions</td></tr>
<tr><td><tt>case-sensitive</tt></td><td>tokens (case-sensitivity (keywords, variable identifiers...))</td></tr>
<tr><td><tt>[_A-Z][_a-zA-Z0-9']*</tt></td><td>tokens (constant regexp (if different from variable identifier regexp))</td></tr>
<tr><td><tt>[_a-z][_a-zA-Z0-9']*</tt></td><td>tokens (type regexp (if different from variable identifier regexp))</td></tr>
<tr><td><tt>[_a-z][_a-zA-Z0-9']*</tt></td><td>tokens (variable identifier regexp)</td></tr>
<tr><td><tt>underscores for functions / types, unclear for modules / constructors</tt></td><td>tokens (what is the standard way for <a href="http://c2.com/cgi/wiki?CapitalizationRules">scrunching together multiple words</a>)</td></tr>
<tr><td><tt>&lt;-</tt></td><td>variable assignment or declaration (assignment)</td></tr>
<tr><td><tt>let v = e in</tt></td><td>variable assignment or declaration (declaration)</td></tr>
</tbody></table>
