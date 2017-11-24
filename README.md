# learn-OCaml
Learn OCaml by example


### functions

After expressions and variables, we finally dive into functions in OCaml today. The whole point of functional programming is to define functions and to apply them. Functions are constructed by the keyword fun, which takes an argument and an expression as the body of the function, e.g.

```ocaml
# fun n -> n + 1;;
- : int -> int = <fun>
```

A function’s type is determined by the types of its argument and return value, written as int -> int in this example. The first int is the type of argument while the second one is of the return value. The above expression, called lambda expression, creates an anonymous function. This makes sense because the name is not an essential part of a function. Mathematically, a function is a mapping between a set of inputs and a set of permissible outputs and each input is mapped to exactly one output. It is not important at all whatever this mapping is called. We can directly apply this anonymous function on a valid input. For example,

```ocaml
# (fun n -> n + 1) 1;;
- : int = 2
```

However, it is not convenient if we want to apply this function many times on different inputs. Since a function is just a value, we can bind a name to it with let construct and apply the function with the name any times later.

```ocaml
# let inc = fun n -> n + 1;;
val inc : int -> int = <fun>
# inc 1;;
- : int = 2
# inc 2;;
- : int = 3
```

Because function definitions are almost everywhere in programs, there is a syntactic sugar to make it less verbose:

```ocaml
# let inc n = n + 1;;
val inc : int -> int = <fun>
```

It is possible to define functions taking multiple arguments.
```ocaml 
# let sum x y = x + y;;
val sum : int -> int -> int = <fun>
```

However, it is mere syntactic sugar because lambda calculus (and thus functional languages) has only unary functions theoretically. The type of above function is int -> int -> int, which should be read as int -> (int -> int), i.e. a function taking int and returning another function int -> int. That is, OCaml translates the evaluation of function that takes multiple arguments (or a tuple of arguments) into evaluating a sequence of unary functions. This technique is called currying in honor of Haskell Curry, who had a significant impact on the design and theory of programming languages. Therefore, it is natural that we can partially apply a multi-argument function. For example, we can redefine the function inc by partially applying the function sum.

```ocaml
# let inc = sum 1;;
val inc : int -> int = <fun>
# inc 2;;
- : int = 3
```
In this way, multi-argument functions can be regarded as nested functions. Therefore, we have another way to define multi-argument functions.

```ocaml
# let f i =
  let g j =
    i + j
  in
  g;;
val f : int -> int -> int = <fun>
```
  
Here g is a function nested inside f, which is not allowed in C/C++/Java. It is important to note that when we use a variable defined earlier in a function, the binding is static in lexical order (again) as illustrated by the following example.

```ocaml
# let i = 1;;
val i : int = 1
# let add j = i + j;;
val add : int -> int = <fun>
# let i = 2;;
val i : int = 2
# let x = add 1;;
val x : int = 2
```

Although we bind i to a new value after defining the function add, it still uses the old binding. It is another evidence that “variables” don’t vary in OCaml. The second let of i just reuses the name rather than assigning it a new value.

As said many times, functional language supports passing functions as arguments to other functions and returning them as the values from other functions. A function that does one of these (or both) is called higher-order function. The derivative in calculus is a common example:

```ocaml
# let d dx f = (fun x -> (f (x +. dx) -. f x) /. dx);;
val d : float -> (float -> float) -> float -> float = <fun>
# let df = d 1e-10;;
val df : (float -> float) -> float -> float = <fun>
# let sqr x = x *. x;;
val sqr : float -> float = <fun>
# let f = df sqr;;
val f : float -> float = <fun>
# let y = f 2.;;
val y : float = 4.000000330961484
```
  
An interesting and natural fact is that operators are functions too in OCaml. Infix operators really only differ syntactically from other functions. In fact, an infix operator can also be used as a prefix operator by surrounding the operator with parens and putting it in a prefix position. The only caution is to keep some space between * and parens if * is a part of operator name. Otherwise, the parser will treat it as comments. As functions, binary operators can be partially applied.

```ocaml
# let inc = (+) 1;;
val inc : int -> int = <fun>
# inc 2;;
- : int = 3
```
  
Since operators are functions, we of course can redefine them, i.e. binding the name of a predefined operator to a new function.

```ocaml
# let (+) x y = x - y;;
val ( + ) : int -> int -> int = <fun>
# 1 + 2;;
- : int = -1
```

This is a silly and dangerous usage. In general, one should not abuse this feature. Besides, this is not overloading. In fact, functions (including operators) can’t have overloaded definitions in OCaml to make type inference easier. On the other hand, we can define new operators in OCaml. A function is treated syntactically as an infix operator if the name of function starts with the infix symbols

```ocaml
= @ ^ ∣ & + - * / $ %
```

followed by zero or more operator characters

```ocaml
! $ % & * + - . / : ? @ ^ ∣ ~
```

The precedence and associativity of new infix operators is determined by its first character in the operator name. User-defined operators make it easier to implement nice-looking embedded languages. For example,

```ocaml
# let (|>) x f = f x ;;
val ( |> ) : 'a -> ('a -> 'b) -> 'b = <fun>
```
  
It is a pipe operator, similar to the one in the UNIX shell. Here is an application:

```ocaml
# 1. |> (+.) 2. |> sqr;;
- : float = 9.
```
In the future posts, we will see a lot of recursive functions. In functional programming, recursion is used a lot more often than iterations. However, the let construct is not sufficient to define recursive functions because the bounded name is only available after the let expression. Therefore, OCaml provides the keyword let rec to define recursive functions.

```ocaml
# let rec pow x i =
  if i = 0 then 1
  else x * pow x (i-1);;
val pow : int -> int -> int = <fun>
```

Mutually recursive functions are also possible with the keyword and.
  
```ocaml
# let rec is_even n =
    if n == 0 then true
    else is_odd (n - 1)
and is_odd n =
    if n == 0 then false
    else is_even (n - 1);;
val is_even : int -> bool = <fun>
val is_odd : int -> bool = <fun>
```

Here is a sloppy example for demo purpose only. No one will really implement is_even or is_odd in this way.

Finally, let’s talk about the labeled and optional arguments. Like Python, OCaml supports labeled arguments, which let us identify a function argument by name. Labeled arguments are very attractive for functions with lots of arguments because they are self-documented and can be passed in a different order than the one of their definition. Labeled arguments are marked by a leading tilde in the declaration of functions. In the function applications, the label (and leading tilde) is in front of the variable to be passed separated by a colon.

```ocaml
let sum ~x ~y = x + y;;
val sum : x:int -> y:int -> int = <fun>
let x = 1;;
val x : int = 1
let z = 2;;
val z : int = 2
sum ~y:z ~x;;
- : int = 3
```

The above example also shows the usage of label punning, i.e. dropping the text after the colon if the label and the name of variable being used are the same.

Arguments with default values are called optional arguments, and can be omitted in function calls — the corresponding default values will be used. Optional arguments are passed in the same syntax as labeled arguments and can be in any order just like labeled arguments.

```ocaml
let sum ?(x=0) y = x + y;;
val sum : ?x:int -> int -> int = <fun>
sum 2;;
- : int = 2
sum ~x:1 2;;
- : int = 3
```
We have touched several aspects of functions in OCaml. Again there are plenty of details left and you are encouraged very much to explore more in the official OCaml website. In the next post, I will talk about the powerful control structure: pattern matching.


### Pattern Matching

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
