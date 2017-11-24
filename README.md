# learn-OCaml
Learn OCaml by example

### Expressions

In previous post, we started our journey of OCaml with a light discussion on functional programming. All functional programming languages are expression-oriented, i.e. every (or nearly every) construction is an expression and thus yields a value. In this post, we will study some basic expressions through code snippets, which can be directly tried out in the interactive OCaml interpreter called “toplevel”. Note that OCaml’s toolchain also includes a bytecode compiler and an optimizing native code compiler. Don’t worry if you don’t have OCaml available on your system. The website Try OCaml provides a complete online REPL in a webpage.

Toplevel repeatedly reads OCaml phrases from the input, then typechecks, compile and evaluate them, then prints the inferred type and result value. Toplevel prints a # prompt before reading each phrase, which can span several lines and is terminated by a double-semicolon. Note that the double semicolon in toplevel exists for historical reasons and is not really needed in the source files for compilation. Besides, an opening comment paren (* will absorb everything as part of the comment until a well-balanced closing comment paren *) is found. Nested comments are handled correctly (Oh Yeah!).

In a terminal, simply type ocaml to launch the toplevel. One can use the toplevel as a calculator. OCaml provides the common arithmetic operators on int and float (can’t start with a decimal point). For example, type the following simple expressions in the toplevel:

```ocaml
 # 2+3;; - : int = 5 # 2.+.3.;; - : float = 5. 
 ```
 
Of course, we will get the right answer 5 and 5., respectively. Compared to dynamically typed languages such as Python, the toplevel first prints the type of the result as OCaml is strongly typed. On the other hand, it looks odd for C/C++ programmers that OCaml uses the different operators (+ vs +.) on int and float, respectively. In fact, OCaml does’t have implicit type conversion and thus the following expression is invalid:

```ocaml
 # 2.+3;; Error: This expression has type float but an expression was expected of type int 
```

Without automatic cast, OCaml prevents some kinds of bugs in C/C++. Moreover, the different set of arithmetic operators on int and float makes the type inference easier. This has more impacts on subtyping and objects, which we will discuss later. Besides, OCaml provides a set of coercion functions on primitive types int, float, bool, char, and string.


```ocaml
 # int_of_float 2. + 3;; - : int = 5 
```

Here we apply the function int_of_float to cast 2. to an integer. In OCaml, function application is as simple as prefix juxtaposition, no parentheses are needed. But parentheses can be used for disambiguation and changing precedence.


```ocaml
 # float_of_int (2 + 3);; - : float = 5. 
```

Now it is time for the classic hello world example.


```ocaml
 # print_string "Hello world!\n";; Hello world! - : unit = () 
```

Several interesting things to notice. First, string is a built-in primitive type and string literals are written in double-quotes with the usual C-style backslash escapes. Strings can be concatenated by the operator ^. The string type consists of a series of 8-bit bytes in essence but there’s no built-in support for handling UTF-8. Strings are very unusual in OCaml in that they are mutable data structures. We will discuss the mutable data structures in another post.

Because every expression yields a value, this printing expression must also return a value. As shown in the top-level, the value is written as () of the unit type. The unit type consists of exactly one value and is used to represent the type of expressions that have “no value”, i.e. expressions that are evaluated for side-effects only. Besides printing functions, the value of a while or for loop (both of which are expressions, not statements) is also of type unit. As while or for loops are expressions, so are if expressions.

Before finding out the types of if expressions, let’s look at the bool type since the presence of the conditional construct implies the presence of boolean values. The type bool is composed of two values true and false. As usual, there are comparison operators returning boolean values. Most of these operators will look familiar: =, <>, <, <=, >, >=. The comparison operators are polymorphic meaning they work on most built-in data types. Note that polymorphic and automatic casting are two different concepts. In fact, one can’t compare two values of different types (e.g. 1 = 1.) due to the strongly-typed nature of OCaml.

Because functions are first-class citizens just like any other values, one may wonder if we can compare two functions for equality? The answer is NO because comparing two functions is undecidable in general. If we can compare two functions, then we can say if a function terminates or not. But the halting problem is undecidable for Turing machines and Lambda calculus.

Back to if expressions. In OCaml, if is much more like the conditional operator ? : in C. The if expression is in the form of


```ocaml
if <bool_expression> then <expression1> else <expression2>
```

OCaml requires that both branches of an if expression have the same type. If the <bool_expression> is true, then <expression1> is evaluated and is the value of the if expression, otherwise <expression2> is evaluated and is the value of the if expression. Since an expression must have a value, the else part is required unless the then part returns ().

We have briefly discussed some aspects of expressions. But there are plenty of features and details left. You are encouraged very much to explore more in the official OCaml website. In the next post of this series, I will talk about the variables in OCaml.

### Variables

In the previous post, we discussed the expressions in OCaml and used the toplevel as a calculator. It is fun but for any serious programs we need variables and functions, which we will talk about in this and next posts. But wait a second. We said that functional programming avoids state and mutable data but variables sound like mutable things, right? Yes, it is true in imperative programming as a variable basically holds program state and refers to the machine representation of data structures and its value changes over the time. However, the idea of a variable in functional programming is different and the purpose is to designate values symbolically. It also lets us factor certain computations by naming a computed value so that it can be reused later. That is, variables are simply name binding to values.

In OCaml, variables can be introduced by the let keyword, called let binding. The name of a variable, i.e. identifier, has to begin with a lowercase letter and consist of letters, digits, the underscore _ or the prime '.

```ocaml
# let x = 2 + 3;;
val x : int = 5
```

As shown above, the toplevel prints the variable x's value and more importantly its type int. Although this is a very simple example, OCaml can infer the types of very complicated expressions by the unification algorithm, which is the process of finding a substitution that makes two given terms equal. Pattern matching, a very power construct in OCaml, is actually also based on the unification algorithm. Type inference is very cool because it enables us to write succinct code like dynamic languages yet type-safe. Of course, we are still allowed to declare the type of a variable explicitly.

```ocaml
# let x : int = 2 + 3;;
val x : int = 5
```

It is usually not necessary but could be needed in rare situations where OCaml compiler cannot determine the type of an expression. Besides, it can also be useful in case of subtyping.

Every variable binding has a scope. In a toplevel, the scope of let binding is everything that follows it in the session. When in a source file (or module), the scope is the remainder of that file/module.

Local binding, i.e. a variable binding whose scope is limited to an expression, is also possible (and encouraged) with the syntax

```ocaml
let <variable> = <expression1> in <expression2>
```

The <expression2> is called the body of the let in construct. The <variable> is defined only in the body <expression2> but not in <expression1>. It is an expression and the value is the value of the body. For example,

```ocaml
# let z =
    let x = 1 in
    let y = 2 in
    x + y;;
val z : int = 3
```

The let in bindings do not have global scope. After evaluation, the variable x is the one defined earlier.

```ocaml
# x;;
- : int = 5
```

That is, a let binding in an inner scope can shadow the definition from an outer scope. Binding is not an assignment and it is static (lexical scoping), i.e. the value associated with a variable is determined by nearest enclosing definition.

In the next post, we will discuss the most exciting thing in OCaml, functions!

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
