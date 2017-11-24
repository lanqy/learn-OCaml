# learn-OCaml
Learn OCaml by example

### OCaml: Pattern Matching

After discussing of functions, we will explore the powerful pattern matching, which is almost everywhere in OCaml. In this post, we will confine us to the control structure feature, which has the following syntax:
```ocaml
match <expression> with
| <pattern1> -> <expression1>
| <pattern2> -> <expression2>
| <pattern3> -> <expression3>
| <pattern4> -> <expression4>
```
The vertical bar preceding the first pattern is optional.

Pattern matching is used to recognize the form of a value/expression and lets the computation be guided accordingly, associating with each pattern an expression to compute. The matching clauses are processed in order, and only the expression of first matching clause is evaluated, whose value will be the value of the entire match expression. If no clause matched, the match expression is said to be non-exhaustive and the exception Match_failure will be raised at runtime. The OCaml compiler usually can detect non-exhaustive matching and issue a warning at compile-time.

But what are patterns? In simplest cases, they are the constants of the primitive types.

```ocaml
# let neg = fun b ->
  match b with
  | true -> false
  | false -> true;;
val neg : bool -> bool = <fun>
 ```
In this case, pattern matching is just like switch in C/C++. The underscore _ could be used as a special symbol, called the wildcard pattern, for the similar purpose of default in switch. For characters, OCaml also recognizes the range patterns in the form of 'c1' .. 'cn' as shorthand for any ASCII character in the range.

```ocaml
# let is_upper = function
  | 'A' .. 'Z' -> true
  | _ -> false;;
val is_upper : char -> bool = <fun>
```
Besides the range pattern, we also use the keyword function in this example. Because the body of many functions are pattern matching only, OCaml provides this syntactic sugar to do pattern matching directly in lambda expressions, which avoids pointlessly naming an argument and then just immediately matching on it.

Besides constant patterns, there are variable patterns that consist of a variable name matches any value, binding the name to the value. The wildcard pattern is actually a special case of variable patterns, but does not bind any name. Here is an example that computes the Fibonacci numbers:

```ocaml
# let rec fib = function
  | 0 -> 0
  | 1 -> 1
  | i -> fib(i-2) + fib(i-1);;
val fib : int -> int = <fun>
```
We can simplify this function with “or” patterns and alias patterns.

```ocaml
# let rec fib = function
  | (0 | 1) as i -> i
  | i -> fib(i-2) + fib(i-1);;
val fib : int -> int = <fun>
```
The pattern <pattern1> | <pattern2> represents the logical “or” of the two patterns <pattern1> and <pattern2>. A value matches <pattern1> | <pattern2> if it matches <pattern1> or <pattern2>. The alias patterns are in the form of <pattern> as <name>. If the matching against <pattern> is successful, the <name> is bound to the matched value, in addition to the bindings performed by the matching against <pattern>.

So far, pattern matching looks like a fancier switch. However, it is way more powerful than that. For example, patterns could be templates that allow selecting data structures of a given shape, and binding identifiers to components of the data structure. To understand what it means, we will study algebraic data types such as variants, tuples and records in the next post
