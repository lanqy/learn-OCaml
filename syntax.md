# Ocaml syntax

### 
<table border="1" cellpadding="6">
<tbody><tr><td><tt>nothing needed</tt></td><td>breaking lines (useful when end-of-line and/or indentation has a special meaning)</td></tr>
<tr><td><tt>(* ... *)</tt></td><td>注释 (可嵌套)</td></tr>
<tr><td><tt>&lt; &gt; &lt;= &gt;=</tt></td><td>对比</td></tr>
<tr><td><tt>min / max</tt></td><td>对比 (min / max (binary or more))</td></tr>
<tr><td><tt>compare</tt></td><td>comparison (returns 3 values (i.e. inferior, equal or superior))</td></tr>
<tr><td><tt>(** ... *)</tt></td><td>documentation comment</td></tr>
<tr><td><tt>= &lt;&gt;</tt></td><td>equality / inequality (deep)</td></tr>
<tr><td><tt>== !=</tt></td><td>equality / inequality (shallow)</td></tr>
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
