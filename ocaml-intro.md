# learn-OCaml
Learn OCaml by example

All from : https://haifengl.wordpress.com/

### Introduction

Functional programming gains popularity in recent years. Many main-stream imperative languages, e.g. C++11 and Java8, are adding functional features (actually templates in C++ are fully functional). Some new languages such as Scala even go further with comprehensive functional supports in an object-orient way. In this series, I will give an introduction to an elegant functional language OCaml, derived from ML. ML-derived languages are well known for their static type systems and type-inferring compilers. Unlike purely functional programming languages such as Haskell, ML/OCaml allows imperative programming that has side-effects. Moreover, OCaml supports object-oriented programming with an interesting design that is very different from class-based approach in C++/Java or message-based approach in Smalltalk/Ruby.

OCaml is very expressive and OCaml programs are concise and clean (but hard to understand for beginners). OCaml’s static type system helps eliminate runtime problems. On the other hand, its type-inferring compiler greatly reduces the need for manual type annotations. Compared to most academia-origined programming languages, OCaml puts a lot of emphasis on performance, which is very important for the use in industry. New languages like F# and Scala are strongly influenced by OCaml. In fact, F# is largely based on OCaml except objects, functors, and polymorphic variants. Therefore, F# even features a legacy “ML compatibility mode” which allow programs written in a large subset of OCaml to be immediately compiled as F#.

Before diving into the details of OCaml, let’s have a light discussion on what’s functional programming from a programmer’s point of view, which will be very helpful to understand the designs of OCaml. For some programmers (e.g. who use JavaScript), functional programming means lambdas (i.e. anonymous functions) and closures. Well, a Java programmer may argue that the inner class does achieve the same effects (of course, less pleasingly succinct). Some people claim that functional programming treats the computation as the evaluation of functions and thus the whole program can be regarded as a single function. While it is true, a C program can also be regarded as a single main function but it is clearly not functional. Interestingly, OCaml has no main entry function at all. Furthermore, people argue that the signature of functional languages is that functions are first-class citizens. Specifically, this means that the language supports passing functions as arguments to other functions, returning them as the values from other functions, and assigning them to variables or storing them in data structure. But we can do all of these in C with function pointers. Of course, there are people talking about the immutable data in functional programming. Clearly immutable data are supported by const keyword in many imperative languages.

All above features touch some parts of function programming but fails to come to the key – functions in functional programming are pure mathematical functions that produce results that depend only on their inputs and not on the program state. In contrast, functions in imperative languages are just subroutines (i.e. a group of statements) for the purpose of code reuse, which may have side effects. Eliminating side effects can make it much easier to understand and predict the behavior of a program, which is one of the key motivations for the development of functional programming. Note that side effects could be useful in some cases, e.g. I/O and pseudo random number generators.

Theoretically, functional programming has its roots in lambda calculus. Many functional programming languages can be viewed as elaborations on the lambda calculus, where computation is treated as the evaluation of mathematical functions (don’t forget it) and avoids state and mutable data. But I won’t go further on this math heavy topic in case scaring away potential readers. In the next post, I will cover the basic building blocks of OCaml programs – expressions.


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

### Algebraic Data Types

In previous post, we showed several simple usages of pattern matching. Pattern matching is actually even more useful with algebraic data types. In functional programming, an algebraic data type is a kind of composite type, i.e. a type formed by combining other types. Two common classes of algebraic type are Cartesian product types, i.e. tuples and records, and sum types (also called variants).

##### Tuples
A tuple is a collection of values, called fields, of arbitrary types.

```ocaml
# let t = (1, "ocaml");;
val t : int * string = (1, "ocaml")
```

To create a tuple, we write multiple values in order between (optional) parentheses and separated by commas. On the other hand, the corresponding type is written as an ordered sequence of n types, separated by *. We usually work with tuple values directly and let the compiler infer the type. Of course, we can explicitly define a tuple type.

```ocaml
# type mytype = int * string;;
type mytype = int * string
```
The way to get values back out of a tuple is by pattern matching:

```ocaml
# let (x, y) = t in x;;
- : int = 1
# let (x, y) = t in y;;
- : string = "ocaml"
```
The structure (x, y) is a pattern to match the fields of tuple. This is a perfect example that patterns are used to select data structures of a given shape, and bind identifiers to components of the data structure. Because it is a very common operation, OCaml has the helper functions fst and snd to return the first and second field of a pair.

```ocaml
# fst t;;
- : int = 1
# snd t;;
- : string = "ocaml"
```
We can easily implement these functions:

```ocaml
# let fst (x, _) = x;;
val fst : 'a * 'b -> 'a = <fun>
# let snd (_, y) = y;;
val snd : 'a * 'b -> 'b = <fun>
```
Note that fst and snd take only one argument that is a tuple. A C/C++ programmer may mistake it as two arguments. It is actually a pattern matching of the input argument. Besides, a variable cannot be bound several times by a given pattern. It is a common mistake that beginners use the same variable twice in a pattern to test for equality between two parts of a data structure.
 
```ocaml
# let eq_pair = function
  | (x, x) -> true
  | _ -> false;;
Error: Variable x is bound several times in this matching
```

However, we can use the when guards for this purpose.

```ocaml
# let eq_pair = function
  | (x, y) when x = y -> true
  | _ -> false;;
val eq_pair : 'a * 'a -> bool = <fun>
```
In above examples, you may notice interesting things like 'a and 'b in the types of functions fst, snd and eq_pair. They are the type variables of the form 'identifier to enable parametric polymorphism in OCaml. When such a polymorphic function is applied to an argument, the type inference mechanism knows how to instantiate the type variable. So for each particular use, the type of a polymorphic function can be determined. We will discuss the polymorphism in details in the next post.

##### Records
Records are similar to tuples for holding multiple values. However, they carry an unordered collection of labeled values. Before making a record, we must declare its type that is enclosed in braces and each field has a name and a type of its own.

```ocaml
# type person = {
  name : string;
  age  : int;
};;
type person = { name : string; age : int; }
```
Record expressions are of the form {f1=e1;...;fn=en} where the identifiers fi are field labels and ei are values.

```ocaml
# let peter = {name = "Peter Pan"; age = 7};;
val peter : person = {name = "Peter Pan"; age = 7}
```
Since fields are unordered in records, it does not matter in what order of fields when creating a record. To “update” a record, we use the keyword “with”.

```ocaml
# let peter = {peter with age = 10};;
val peter : person = {name = "Peter Pan"; age = 10}
```
Note that records are immutable by default. The “update” actually just create a new record. In the example, we don’t declare the type of record peter while the compiler successfully determines the type based on the filed labels. This is possible because records have a flat namespace. In old time, this will confuse the compiler’s type inference algorithm if fields in different records share the same name. Since OCaml 4.01, the compiler is smart enough to handle it in many situations.

```ocaml
# type person =
  {
    name : string;
    age  : int;
  };;
type person = { name : string; age : int; }
# type people =
  {
    name   : string;
    height : float;
  };;
type people = { name : string; height : float; }
# {name = "Peter Pan"; age = 10};;
- : person = {name = "Peter Pan"; age = 10}
# {name = "Alice"; height = 4.};;
- : people = {name = "Alice"; height = 4.}
```
Because the fields are labeled in records, it is easy to access them.

```ocaml
# peter.name;;
- : string = "Peter Pan"
# peter.age;;
- : int = 10
```
On the other hand, pattern matching is still our good friend to work with records.

```ocaml
# let print_person = function
  | {age; _}    when age < 10 -> print_string "kids"
  | {age; name} when age < 20 -> print_string name
  | _ -> ();;
val print_person : person -> unit = <fun>
```
##### Variants
 
In C++, we have the union type to allow a piece of memory to be accessed as different data types. However, it is error-prone and has many restrictions. The boost library provides the variant class as a safer alternative. However, it is still tedious to manipulate. In OCaml, we have a much better concept, the sum types or variants, to organize heterogeneous values of various types into the same type. The declaration of a variant type lists all possible shapes for values of that type. Each case is identified by a name, called a constructor, which serves both for constructing values of the variant type and inspecting them by pattern matching. Constructor names are capitalized to distinguish them from variable names that must start with a lowercase letter. Variants can be introduced with the following syntax:

```ocaml
type typename =
| Identifier1 of type1
| Identifier2 of type2
| Identifier3 of type3
| Identifier4 of type4
```
Like match with construct, the first vertical bar is also optional. The enum types in C++ are a special case of variants of constant constructors that take no arguments.

```ocaml
# type t =
  | Male
  | Female;;
type t = Male | Female
```

Once introduced, a constant constructor can be used afterwards exactly like a numeric constant.

```ocaml
# let x = Male;;
val x : t = Male
```
##### Lists

Of course, constructors with arguments are of more interest. In fact, the list types are sum types. Lists are extensively used in functional programming. A list is a sequence of values of the same type in the form [e1; e2; …; en]. Lists can also be built from the empty list [] by adding elements in front using the :: (“cons”) constructor.

```ocaml
# [1; 2; 3; 4];;
- : int list = [1; 2; 3; 4]
# "Life" :: ["is"; "good"];;
- : string list = ["Life"; "is"; "good"]
```

Conceptually, we can define the list type as

```ocaml
# type 'a list =
  | E (* empty list *)
  | Cons of 'a * 'a list;;
type 'a list = E | Cons of 'a * 'a list
```

As built-in types, E and Cons are replaced by [] and :: in OCaml respectively, providing a feeling of operators. But they are not operators as shown in the following

```ocaml
# (::) 1 [];;
Error: Syntax error: operator expected.
```
But it is okey to do

```ocaml
# (::)(1, []);;
- : int list = [1]
```

which shows that [] and :: are actually constructors.

In the type definition of lists, 'a is a type variable and stands for arbitrary type. Right now, C++ programmers may regard it as the type parameters in C++ templates although the mechanisms are different.

Clearly, lists in OCaml are same as the singly linked lists in C/C++ that are managed by pointers. But OCaml programmers do not need to manage memory and pointers explicitly. All memory management is done automatically by the compiler and runtime.

As with tuples and records, inspecting and destructuring lists are performed by pattern matching. List patterns have the exact same shape as list expressions, with identifier representing unspecified parts of the list. For example, we can define the function mem to test if a value exists in a list, and the function assoc to return the value associated with a given key in the list of pairs:

```ocaml
# let rec mem x = function
  | [] -> false
  | y :: l -> x = y || mem x l;;
val mem : 'a -> 'a list -> bool = <fun>
# let rec assoc key = function
  | (k, v) :: _ when k = key -> v
  | (k, v) :: l -> assoc key l
  | [] -> raise Not_found;;
val assoc : 'a -> ('a * 'b) list -> 'b = <fun>
```
 
It is not necessary to implement these functions by yourself. They are available in the module List of standard library. Of the List module, the map function is probably most used in programs. It applies a given function to each element of a list, and returns the list of the results.

```ocaml
# List.map (fun n -> n * 2) [1;2;3;4];;
- : int list = [2; 4; 6; 8]
```

The map function can be easily defined as follows

```ocaml
let rec map f = function
  | [] -> []
  | x :: l -> f x :: map f l;;
 ```
It is also a good example that functional programming prefers recursions to iterations.

##### Options
Options are another useful standard type that is defined by constructors.

```ocaml
type 'a option =
  | None
  | Some of 'a;;
 ```
 
In OCaml, options are widely used to represent nullable values. It is a little like NULL in C/C++, but in a type and memory safe way. Recall optional arguments are arguments with default values. In fact, we may not provide the default value of optional arguments in the definition of a function. If so, the optional argument will be of option type with the default value None.

```ocaml
# let add ?x y =
  match x with
  | None -> y
  | Some x -> x + y;;
val add : ?x:int -> int -> int = <fun>
```
We have reviewed some OCaml’s built-in algebraic data types. A lot of power of OCaml comes from its rich type system indeed. During our review, we also frequently meet polymorphic types and functions. In the next post, we will discuss OCaml’s approaches of polymorphism.

### Polymorphism

Object-oriented programmers are familiar with polymorphism. It is one of major capabilities of object-oriented languages besides encapsulation and inheritance. For most C++/Java programmers, polymorphism means dynamic dispatch, i.e. when a method is invoked on an object, the object itself determines what code gets executed by looking up the method at run time in a table associated with the object. Actually there are several fundamentally different kinds of polymorphism, which are all supported in C++.

##### Ad hoc polymorphism
Ad hoc polymorphism allows a function to denote different and potentially heterogeneous implementations depending on a limited range of individually specified types and combinations. It is supported in C++ using function overloading.

##### Parametric polymorphism
Parametric polymorphism allows a function or a data type to be written generically so that it can handle values identically without depending on their type. In C++, it is supported by templates and usually known as generic programming or compile-time polymorphism.

##### Subtyping
Subtype polymorphism (also called inclusion polymorphism) allows a function to be written to take an object of a certain type T, but also work correctly if passed an object of a subtype S. In C++, it is also known as runtime polymorphism.
As we already learned, OCaml doesn’t support function overloading because it is pretty hard to have type inference and function overloading altogether. But OCaml does support parametric polymorphism and subtyping. Subtyping polymorphism is part of object-oriented programing, which we will explore later. In this post, we will focus on parametric polymorphism.

Recall that C++ provides parametric polymorphism through templates, which is very powerful. The template system in C++ is indeed Turing-complete at compile time. In fact, it is also pure functional! There is no C++ kind of templates in OCaml. However, when OCaml’s type inference determines that an expression is valid for any type, it is automatically made polymorphic, parameterized by type variables. Type variables are lowercase identifiers preceded by a single quote ', normally 'a, 'b, 'c and so on. A type variable represents an arbitrary type. For example, we can define the identity function that returns its argument as follows.

```ocaml
# let id x = x;;
val id : 'a -> 'a = <fun>
# id 1;;
- : int = 1
# id "OCaml";;
- : string = "OCaml"

```
The type val id : 'a -> 'a says that the id function takes an argument of some arbitrary type 'a and returns a value of the same type. The emphasized part is very important. Although the function can return a value of arbitrary type, the return type depends on the type of the argument. So for each particular use, the type of id can be determined. If not so, a function of completely unspecified type such as 'a -> 'b would allow any type conversion, a big contradiction to OCaml’s strong static typing.

Multiple type variables could be involved in a function definition. Recall the built-in functions fst and snd that return the components of a pair have the following types:

```ocaml
# let fst (x, _) = x;;
val fst : 'a * 'b -> 'a = <fun>
# let snd (_, y) = y;;
val snd : 'a * 'b -> 'b = <fun>
```

The compiler successfully determines that fst takes an argument of type 'a * 'b and returns a value of type 'a. Clearly, the second component is irrelevant to the function body of fst and its type, denoted as 'b, could be different from the type of the first one. On the other hand, OCaml’s compiler can also detect the constrains between the types of arguments. For example,
 
```ocaml
# let eq x y = x = y;;
val eq : 'a -> 'a -> bool = <fun>
```
The compiler enforces that the function eq takes two arguments of same type, inferred from the type of the built-in comparison functions. BTW, the built-in hashing functions are also polymorphic.

Although it is very cool that the compiler can automatically infer a polymorphic type, it is not desired in some cases. To avoid it, we can explicitly declare the type of argument.

```ocaml
# let id_int (i:int) = i;;
val id_int : int -> int = <fun>
```
But why would we want to do this? Generics is cool, right? One reason is performance. Come back to the built-in comparison functions. Because it can work on any types, the compare function is pretty heavy. It actually calls an internal C function. In contrast, the following simple comparison function on int

```ocaml
# let cmp_int (a:int) (b:int) = a - b;;
val cmp_int : int -> int -> int = <fun>
```
 
will be a simple register operation when compiled to machine code. If we do a lot of comparisons and the function is expected to apply on a specific type, it is of course better to declare it monomorphic explicitly.

In OCaml, parametric polymorphism is introduced only through the let construct, which is called value restriction. Thus the function resulting from the application (including partial application) is not fully polymorphic.

```ocaml
# let weak_id = id id;;
val weak_id : '_a -> '_a = <fun>
# weak_id 1;;
- : int = 1
# weak_id;;
- : int -> int = <fun>
# weak_id "OCaml";;
Error: This expression has type string but an expression was expected of type
         int
```
 
The type variable '_a is now preceded by an underscore, which means some unknown type. The weak_id function can be used with values of only one type. When we apply the weak_id function to an int, the type of weak_id is fixed as int -> int, and it is no longer possible to apply to a value of other types.

Here is an example of weak polymorphism by partial application:

```ocaml
# let map_id = List.map id;;
val map_id : '_a list -> '_a list = <fun>
# map_id [1; 2];;
- : int list = [1; 2]
# map_id;;
- : int list -> int list = <fun>
```
To recover the full polymorphism, we can use a technique called eta-expansion. It sounds complicated but actually very simple: define the function with an explicit functional abstraction. That is, add a function construct or an extra parameter:

```ocaml
# let map_id l = List.map id l;;
val map_id : 'a list -> 'a list = <fun>
```
 
But why value restriction? Especially, it forbids polymorphism in many cases where it would be sound, just like our examples. Well, it is a solution to the soundness problem created by OCaml’s imperative features. To understand it, we will cover the imperative programming in OCaml in the next post.

### Imperative Programming

So far, we have been focusing on the functional features of OCaml, which doesn’t allow the destructive operations (e.g. assignment) of entities in a program. Accordingly, variables, i.e. identifiers referring to immutable values, are used in a mathematical sense. Although some languages such as Haskell prompt purely functional programming, OCaml does allow imperative programming, which we will discuss today.

In imperative programming, computation is described as a series of statements that change a program’s state. The imperative programming is very nature in the context of Turing machine. Almost all modern computers are based on the model of Turing machine, where the program state is defined by the contents of memory and the machine instructions are used to modify them. Besides assignments, imperative programming also makes sense for some particular evaluation strategies such as input-output and exceptions. Because the concept and model of input-output are pretty uniform across modern operating system and programming languages, we will skip it while focus on mutable data structures and exceptions in what follows.

##### Mutable Data Structures
In OCaml, the principal tool to hold program’s state is the reference cell. Like the reference in C++, a reference cell always holds a value and the contents can be updated by assignment. Three basic operations are provided to create a reference cell, to retrieve the value, and to assign a new value.

```ocaml
# ref;;
- : 'a -> 'a ref = <fun>
# (!);;
- : 'a ref -> 'a = <fun>
# (:=);;
- : 'a ref -> 'a -> unit = <fun>
```
 
The expression ref e creates a reference cell with the initial value e. The expression !r returns the value in the reference cell r, and the expression r := e replaces the contents with the value e.


```ocaml
# let n = ref 1 ;;
val n : int ref = {contents = 1}
# !n;;
- : int = 1
# n := 2;;
- : unit = ()
# !n;;
- : int = 2
```

The really interesting thing in this example is the toplevel printout val n : int ref = {contents = 1}. It looks like that a reference cell is kind of a record with single field contents. Yes, it is. References cells are just a particular case of records with mutable fields in OCaml. By default, record fields are immutable. But a record field maybe declared as mutable in the type definition with the mutable keyword before the field label.

```ocaml
# type person =
  {
    name : string;
    mutable age : int;
  };;
type person = { name : string; mutable age : int; }
# let peter = {name = "Peter Pan"; age = 7};;
val peter : person = {name = "Peter Pan"; age = 7}
# peter.age <- 10;;
- : unit = ()
# peter.name <- "Peter New";;
Error: The record field name is not mutable
```
Note that we use the operator <- for record field assignment, which is different from the operator := for reference cells. As reference cells are just records, it is possible to update them in the way of record:


```ocaml
# n.contents <- 3;;
- : unit = ()
# !n;;
- : int = 3
```
Arrays, fixed-size vectors of values of the same type, are also mutable in OCaml. Array literals are in the form [|e1; e2; …; en|]. Out-of-bounds accesses for arrays will result in an exception raised.

```ocaml
# let a = [| 1; 2; 3 |];;
val a : int array = [|1; 2; 3|]
# a.(1) <- 4;;
- : unit = ()
# a;;
- : int array = [|1; 4; 3|]
# a.(5);;
Exception: Invalid_argument "index out of bounds".
```
Strings are essentially byte arrays and thus also mutable. However, strings will become immutable in OCaml 4.02, which is a really good step to fix the historical cruft.

One important thing to notice is the physical sharing of two arrays/records. In OCaml there are no implicit array/record copying. If we give two names to the same array/record, every modification on one array/record will be visible to the other:


```ocaml
# let p = peter;;
val p : person = {name = "Peter Pan"; age = 7}
# p.age <- 10;;
- : unit = ()
# p;;
- : person = {name = "Peter Pan"; age = 10}
# peter;;
- : person = {name = "Peter Pan"; age = 10}
# let b = a;;
val b : int array = [|1; 4; 3|]
# b.(0) <- 0;;
- : unit = ()
# a;;
- : int array = [|0; 4; 3|]
```

In the previous post, we show that functions from partial application are weakly polymorphic because of value restriction. The value restriction doesn’t allow mutable data structures such as reference cell and array fully polymorphic either:

```ocaml
# let r = ref [];;
val r : '_a list ref = {contents = []}
# r := [3];;
- : unit = ()
# r;;
- : int list ref = {contents = [3]}
```

Otherwise, it would allow a value of one type to be cast to another and hence would break type safety. For example, the following program would pass type check without value restriction.


```ocaml
let r: 'a option ref = ref None;;
let r1: string option ref = r;;
let r2: int option ref = r;;
r1 := Some "foo";;
let v: int = !r2;;
```

##### Control Structures
Imperative programming describes the computation as a series of statements that change a program’s state. Therefore, the basic imperative structures is the sequence, which permits the left-to-right evaluation of a sequence of expressions separated by semicolons. A sequence of expressions is itself an expression, whose value is that of the last expression in the sequence. It should be emphasized that the semicolon ; is not a terminator as it is in C/C++. It is indeed like the comma , operator in C/C++. Because the sequence is an opened construct, it may introduce ambiguities. To be correct (or clear), we can add an enclosing begin..end or parentheses.


```ocaml
# let factorial n =
  let f = ref 1 in
  for i = 2 to n do
    f := !f * i
  done;
  !f;;
val factorial : int -> int = <fun>
# factorial 10;;
- : int = 3628800
```
 
OCaml also has for loop and while loop. The loops are expressions which have the value () of type unit. The above is a simple example using reference cell, sequence, and for loop altogether. I will not spend more time on the loop constructions. In practice, I rarely use them with OCaml. Instead of iterations, recursions are generally preferred in functional programing. We will discover more on recursions in the next post.

##### Exceptions
The exception mechanism in OCaml is similar to those in other languages such as Java and Python. It is mainly used for signalling and handling errors. But exceptions can also be used as a general-purpose non-local control structure. Exceptions, of the type exn, can be thrown with the raise operator and be trapped with the try..with construct.

```ocaml
try expression with
| pattern1 -> expression1
| pattern2 -> expression2
| pattern3 -> expression3
| pattern4 -> expression4
```

The expression is first evaluated and its value is returned as the result of the try expression if it doesn’t raise an exception. Otherwise, the exception value will go through the pattern match in the with part. If patterni matched, the corresponding expressioni is evaluated and returned as the result of the try expression. So expressioni must be of the same type as the expression of try body. The with part is not required to be complete as regular pattern matching. If no pattern matches, the exception is propagated to the next exception handler.

The exn type is similar to the variant type. However, it is open, i.e. new exceptions can be added at different parts of the program.

```ocaml
# exception Empty_list;;
exception Empty_list
# let head l =
  match l with
  | [] -> raise Empty_list
  | hd :: _ -> hd;;
val head : 'a list -> 'a = <fun>
# head [];;
Exception: Empty_list.
# try head [1; 2; 3] with
  | Empty_list -> -1;;
- : int = 1
```
 
The above example shows some simple usages of exceptions. Exceptions (and more general error-handling) could be very complicated in software engineering. We won’t discuss further on this big topic in such a short post.

After eight sections, we have covered a lot of basic features of OCaml. Next time, we will show more examples using what we have learned. As you will see, most of them will be recursions.

### Recursion

We have learned many interesting features of OCaml in our journey. Today we will do some exercises with them. As you will notice, many examples are recursive, which is very common in functional programming. Computer scientists love recursion because a lot of data structures and algorithms exhibit recursive behavior. In particular, divide and conquer is an important algorithm design paradigm based on multi-branched recursion, which solves a large problem by breaking it up into smaller and smaller pieces until we can solve it immediately for small trivial cases and then combine the results. So if a problem has the following properties:

- A simple base case (or cases)
- A set of rules that reduce all other cases toward the base case
- we can solve it recursively. A common mistake when writing a recursive function is missing base case. Apparently, it will lead to infinite recursion, similar to infinite loop.

In previous post, we show an imperative implementation of factorial function. As the factorial function can be naturally  represented as n! = n * (n-1)!, it can be easily implemented recursively.

```ocaml
let rec factorial = function
  | (0|1) -> 1
  | n when n < 0 -> failwith "negative argument for factorial"
  | n -> n * factorial(n - 1);;
```

Here failwith is a standard library function that raises exception Failure with the given string. Not all algorithms are intuitive to be written recursively. For example, it is simple to write a naive primality test by for loop. However, the recursion version may be a little bit hard for beginners to grasp.

```ocaml
let is_prime n =
  let rec is_not_divisor d =
    d * d > n || (n mod d <> 0 && is_not_divisor (d+1))
  in
  match n with
  | 1 -> false
  | n when n <= 0 -> failwith "negative argument for primality test"
  | n -> is_not_divisor 2;;
```

Although this is a good example how to rewrite an iteration recursively, I don’t recommend to do it painstakingly if not necessary.

One possible reason that recursions are almost everywhere in OCaml programs is because of lists, the bread and butter of functional programming. Recall that list itself is a recursive data structure:

```ocaml
type 'a list =
    []
  | :: of 'a * 'a list;;
```
It is therefore not a surprise that many functions handling lists are implemented in a recursive way, especially with pattern matching. Suppose we want the sum of a list of integers.

```ocaml
let rec sum = function
    [] -> 0
  | x :: tl -> x + (sum tl);;
```

Similarly, we can also calculate the sums of a list of floats, or concat a list of strings. They are the examples of a general operation, fold (or reduce, accumulate, aggregate, …), that traverses a recursive data structure and builds a return value through an accumulator that stores partial results. For lists, the folding could be from left to right,

```ocaml
let rec fold_left f accu l =
  match l with
    [] -> accu
 | a::l -> fold_left f (f accu a) l;;
or from right to left.

let rec fold_right f l accu =
  match l with
    [] -> accu
  | a::l -> f a (fold_right f l accu);;
```

Both functions are available in the standard library module List. Note that fold_left and fold_right may produce different results on the same list with the same combine operation.

```ocaml
# List.fold_left  (-) 0 [1;2;3;4];;
- : int = -10
# List.fold_right (-) [1;2;3;4] 0;;
- : int = -2
```

Now, let’s implement the famous quicksort, a classic divide-and-conquer algorithm, on lists. Quicksort first divides a large list into two smaller sub-lists: the low elements and the high elements. Quicksort can then recursively sort the sub-lists. We first implement the partition function that returns a pair of lists (l1, l2), where l1 is the list of all the elements of l that satisfy the predicate p, and l2 is the list of all the elements of l that do not satisfy p.

```ocaml
let partition p l =
  let rec part yes no = function
      [] -> (List.rev yes, List.rev no)
    | x :: l -> if p x then part (x :: yes) no l else part yes (x :: no) l
  in
  part [] [] l;;
```

Then it is straightforward to write the quicksort function. For simplicity, we use the first element in the current list as the pivot, which could be far from the optimal choice. It is actually the worst choice if the list is already sorted.

```ocaml
let rec quicksort = function
    ([] | [_]) as l -> l
  | pivot :: tl ->
      let less x = x < pivot in
      let left, right = partition less tl in
      (quicksort left) @ [pivot] @ (quicksort right);;
```
The operator @ concats two lists to one. Try it on some short lists to verify our implementation.

```ocaml
# quicksort [3; 2; 4; 1; 7; 9; 8];;
- : int list = [1; 2; 3; 4; 7; 8; 9]
```

For long lists (says of 1 million elements), however, we will get the error

Stack overflow during evaluation (looping recursion?)
The reason is that every function call pushes a new stack frame to the call stack. Given that call stack space is very limited, it is easy to get stack overflow with recursions on large lists. Fortunately, most compilers are smart to optimize tail calls without adding a new stack frame. A tail call is a function call performed as the final action of a function. If all of recursive calls are tail calls, it is said to be tail-recursive. Note that tail call must be the last action in the sense of computation, not just lexically. Recall the map function:

```ocaml
let rec map f = function
    [] -> []
  | x :: l -> f x :: map f l;;
```

Lexically, the recursive call seems the last step of function. But it is not. The cons operator :: is indeed. It is possible to rewrite the map function in a tail-recursive way:

```ocaml
let rec map_tailrec acc f = function
    [] -> List.rev acc
  | hd :: tl -> let r = f hd in map_tailrec (r :: acc) f tl;;
```

This is achieved by an additional “accumulator” argument (acc in the above example) that accumulates the result of the operations at each step. We can rewrite a tail-recursive factorial function in similar way. Do it as an exercise and have fun!

Besides recursive functions, recursive data types are also common and natural in OCaml. List is an examined example. Binary tree is another good example.

```ocaml
type 'a tree =
    Leaf of 'a
  | Node of 'a * 'a tree * 'a tree;;
```

Finally, let’s create a calculator as our last example.

```ocaml
type exp =
  | Val of float
  | Var of string
  | Add of exp * exp
  | Mul of exp * exp;;
```
According to this type, an expression is either an float constant value, or a variable denoted by a string, or the addition of two expressions, or the multiplication of two expressions. The below is an example of such expression ((x + 1.) * 3.).

```ocaml
let e = Mul (Add (Var "x", Val 1.), Val 3.);;
```

To make it more visually appealing, we can define a couple of helper functions:

```ocaml
let ( + ) x y = Add (x, y);;
let ( * ) x y = Mul (x, y);;
let cst x = Val x;;
let var x = Var x;;
```
Now, we can write the expression in the normal infix way. The function cst and var are to “lift” floats and strings to the type exp.

```ocaml
let e = (var "x" + cst 1.) * cst 3.;;
```

Now we are going to write a function eval to evaluate the value of an expression. Because expressions may contain variables, eval has to take an environment argument (env in the example) that is an associative list of (string, float).

```ocaml
let rec eval env = function
  | Val x -> x
  | Var x -> List.assoc x env
  | Add (x, y) -> eval env x +. eval env y
  | Mul (x, y) -> eval env x *. eval env y;;
```

The computation is straightforward based on the type definition. Although it is very simple, we finish a calculator in only 14 lines. How beautiful OCaml is! To make this small expression system more complete, one may make the exp type polymorphic. To do it nice and easily, we should use GADT, which was introduced in OCaml 4.00. We will skip this advanced topic and focus on the module system in the next post.

### Modules

In all previous posts, we tried out OCaml features in the toplevel. The real world applications of course are divided into multiple source files (.ml files) that can be compiled and linked to byte code or native executables. To compile a file, one can use ocamlc (generating .cmo object file of byte code)

```ocaml
$ ocamlc -c a.ml
```

or ocamlopt (generating .cmx object file of native code). The basic usage is just like a C compiler. See the manual for details. To link one or more object files to an executable, we can do

```ocaml
$ ocamlc -o a.out a.cmo b.cmo
```
This can also be done in one step

```ocaml
$ ocamlc -o a.ml a.cmo b.ml
```

The order of the source files matters during compiling and linking:

If b.ml depends on a.ml, a.ml must be compiled first. And a.cmo must be front of b.cmo in the link line.
There is no main entry in OCaml programs and .ml files are evaluated in the link order.
Therefore, cyclic dependencies between source files are not allowed.

In real world, we always split large programs into multiple pieces, which not only make building faster but also add structure to them if abstraction nicely. They make large programs understandable, maintainable, and reusable. To enforce abstraction, OCaml actually treats each source file as a module. Besides .cmo (or .cmx) files, OCaml compiler also generates .cmi files, which specify the interfaces (or signatures in OCaml terms) of modules. By default, all type definitions, exceptions and values (including functions) are exposed. For each .ml file, however, one may explicitly write a .mli file to hide the implementation details. Only types, exceptions and values listed in the .mli can be accessed by other modules/files. One can generate the default .mli file by compiler

```ocaml
$ ocamlc -i a.ml
```
However, it is a bad practice because we should always think and define interfaces first.

The compiler derives the module name by taking the capitalized base name of the source file (.ml or .mli file). This is because of the requirement that module names must be capitalized. Other modules may refer to components defined in mymodule.ml under the names Mymodule.name. So modules also provide namespaces besides structuring programs. We can also do open Mymodule, then use unqualified names. However, it may introduce name conflicts if the same identifier is defined in multiple modules. If so, the identifiers of module in last open win. We can still use fully qualified names to solve the conflicts. But a better and preferred way is local open:

```ocaml
let sum x y =
  let open Int64 in
  add x y
```
Lightweight local open is also possible:

```ocaml
let sum x y =
  Int64.(add x y)
```

In Java, each top-level class residents in a .java file but one can define nested classes in another class. In OCaml, we can similarly define sub-modules inside a file that corresponds to a top-level module. Just like .mli and .ml, we have the signature construct sig...end and the structure construct struct...end when defining a module. As an abstraction mechanism, modules package together related definitions, such as the definitions of a data type and associated operations over that type. Signatures are interfaces for modules while structures contains an arbitrary sequence of definitions. I would like to emphasis again that we should think and define the signature first. For example, the following is a signature packaging together a hash map data type and their operations:

```ocaml
(** module signature *)
module type HashMapSig = sig
  (** Abstract data type of hash table. The users of module
      don’t need to know its details and should NOT know. *)
  type t
  (** Concrete key type *)
  type key_t = string
  (** Concrete value type *)
  type value_t = float
  (** hash function type *)
  type hash = key_t -> int

  (** Creates a hash table of given size *)
  val make : int -> t
  (** Gets the value of a key *)
  val get  : t -> key_t -> value_t option
  (** Puts a key value pairs into hash table *)
  val put  : t -> key_t -> value_t -> unit
end
```

The structures, usually given a name with the module binding, provide the implementations. The following is a naive implementation of our hash map. One may define another structure implementing the same signature while using different internal data structures and algorithms. The abstraction provided by modules enables us to easily switch between implementations.

```ocaml
module HashMap : HashMapSig = struct
  type key_t = string
  type value_t = float
  type t = (key_t * value_t) option array
  (* To initialize hash table *)
  let  empty : (key_t * value_t) option = None
  (* Dummy implementation. *)
  let  hash _ = 0
  let  make n = Array.make n empty
  let  get : t -> key_t -> value_t option =
    fun tbl key -> match tbl.(hash key) with None -> None | Some (_, v) -> Some v
  let  put : t -> key_t -> value_t -> unit =
    fun tbl key value -> tbl.(hash key) <- Some (key, value)
end
```

When binding a name to a structure, it is okey without restricting it by a signature. If so, all definitions in the structure will be exposed. However, it is better to have the signature restriction for encapsulation. With the signature restriction, we hide some implementation details of HashMap, e.g. local value/function defitions such as empty. More interestingly, we can export restricted types. For instance, the signature HashMapSig makes the type t abstract by not providing its actual representation as a concrete type. The users of modules should not be aware of or concern about the exact data types as long as they can create and work on the data type by the provided functions. On the other hand, the structure designers are free to choose the suitable data structures for different applications.

Between abstract and concrete types, we could also have private types (declared with keyword private) in a signature that reveal some, but not all aspects of the implementation of a type. If a variant or record type is private, we won’t be able to construct its values (or update mutable fields) outside of the structure. But they can be de-structured normally in pattern matching or via the dot notation for record accesses.

```ocaml
module M : sig
  type t = private A | B of int
  val a : t
  val b : int -> t
  end
= struct
  type t = A | B of int
  let a = A
  let b n = assert (n > 0); B n
end;;
```

Apply the example above in the toplevel and try the following:

```ocaml
# let x = M.A;;
Error: Cannot create values of the private type M.t
# let x = M.B 1;;
Error: Cannot create values of the private type M.t
# let x = M.b 1;;
val x : M.t = M.B 1
# match x with
    M.A   -> print_string "A"
  | M.B x -> print_int x;;
1- : unit = ()
```

Private type abbreviation is also possible. But first of all, what is type abbreviation? In short, a type abbreviation is an alias or alternate name for a type, just like typedef in C/C++. With type abbreviations, it is easier to change an underlying type without changing all the code that uses the type. Because it is an alias, the type symbol introduced by type abbreviation is compatible with the original implementation type and should be interchangeable with it anywhere.

```ocaml
type t = int;;
let x : t = 1;;
x + 1;;
x = 2;;
```

Unlike a regular type abbreviation, a private type abbreviation declares a type that is distinct from its implementation type. However, coercions from the type to implementation type, by using the :> operator, are permitted. The following example define a module of nonnegative integers based on private type abbreviation:

```ocaml
module N : sig
  type t = private int
  val of_int : int -> t
  val to_int : t -> int
  end
= struct
  type t = int
  let of_int n = assert (n >= 0); n
  let to_int n = n
end;;
```
Try the expression below to understand what we discussed.

```ocaml
# let x = N.of_int 1;;
val x : N.t = 1
# x + 1;;
Error: This expression has type N.t but an expression was expected of type
         int
# (x :> int) + 1;;
- : int = 2
# (1 :> N.t) + x;;
Error: Type int is not a subtype of N.t
```
From the error message, we can see that OCaml treats N.t as a subtype of int but not vice versa, which makes sense in mathematics. Note that sub typing is a concept strongly related to class/object inheritance in object-oriented languages. Clearly, it is more flexible in OCaml.

The third flavor of private types is private row types (e.g. objects and polymorphic variants). Since we have not cover row types, we skip this topic here.

Our hash map module is not flexible because the key type, value type, and hash function are hard coded. It would be nicer if we can parameterize structures with pluggable definitions. OCaml supports this by functors that are “functions” from structures to structures. It allows the construction of a module parameterized by one or more other modules. A functor is simply a structure A parameterized by another (or more) structure B (and the expected signature). The functor can then be applied to some implementation of B, yielding the corresponding structure of A. Consider our hash map example. We can define a signature including the key type, value type, and hash function type.

```ocaml
module type HashSig = sig
  type key_t
  type value_t
  val  hash : key_t -> int
end
```
Now, we make the type key_t and value_t abstract in HashMapSig.

```ocaml
module type HashMapSig = sig
  type t
  type key_t
  type value_t

  val hash : key_t -> int
  val make : int -> t
  val get  : t -> key_t -> value_t option
  val put  : t -> key_t -> value_t -> unit
end
```
Finally, we parametrize the HashMap structure (called MakeHashMap here following the common name convention for functors) with HashSig.

```ocaml
module MakeHashMap (Hash : HashSig)
  : HashMapSig with type key_t = Hash.key_t
               with type value_t = Hash.value_t =
struct
  include Hash
  type t = (key_t * value_t) option array
  let  empty : (key_t * value_t) option = None
  let  make n = Array.make n empty
  let  get tbl key =
    match tbl.(hash key) with
      None -> None
    | Some (_, v) -> Some v
  let put : t -> key_t -> value_t -> unit = fun tbl key value ->
    tbl.(hash key) <- Some (key, value)
end
```

Note that we use sharing constraint (line 2 and 3) to make sure that the two modules Hash and HashMapSig define identical abstract types. We also use include construct (line 5) to extend the structure with definitions in Hash.

Modules are very different from what we learned in previous posts as they are not first-class. That means we can’t define a variable whose value is a module, or a function that takes a module as an argument. Conceptually, OCaml is divided into two worlds:

- a core language about values and types
- a module language about structures and signatures
- With first-class modules introduced in OCaml 3.12, it got a little bit blurred. First-class modules are ordinary values that can be created from and converted back to regular modules. With first-class modules, we can do advanced things such as runtime module choice (or dependency injection if you are from the Java world). We won’t cover first-class modules in this short tutorial. In the next post, we will discuss objects, which provide another approach of abstraction and encapsulation.

### Objects

In previous post, we had a quick review of OCaml’s module system, which provides abstraction, encapsulation, and namespace. Today, we will look into OCaml’s supports of object-oriented programming (OOP). Besides abstraction and encapsulation, OOP also provides inheritance, subtyping, and dynamic binding, which modules don’t support.

In OOP, an object contains some data called fields/attributes and has methods manipulating these data. Therefore, OOP is intrinsically imperative as objects hold program state. The creators of OCaml carefully designed the language to make OOP live nicely with functional programming.

Because OOP has a huge influence to many programming languages in last 40 years, I assume that you are already familiar with the basic concepts. However, C++/Java programmers and Smalltalk/Ruby programmers please hold tight. You will get a lot of surprises in what follows.

##### Objects

In C++/Java, classes play a central role. Remember C++ was originally called “C with Classes”. In these class-based languages, a class is indeed a data type while an object is a variable of specific class. Just like a primitive data type defining the data representation and valid operators on its variables, a class definition includes member fields and methods.

In pure OOP languages such as Smalltalk/Ruby, everything including primitive values is an objects and all computations are done by sending messages to objects to do so. Any message can be sent to any object: when a message is received, the receiver determines whether that message is appropriate. Actually, messaging is the most important concept in Smalltalk/Ruby despite the attention given to objects. Same as in C++/Java, classes are the blueprints of objects and an object is always an instance of a class. Interestingly, classes are actually first-class objects in Smalltalk/Ruby — each is an instance of class Class (yes, we have a recursion here 🙂 ). Therefore, classes can receive messages just like any other objects and can be created dynamically at execution time.

Very different from C++/Java and Smalltalk/Ruby, an object is not required to associate with a class in OCaml. In fact, objects and their types (object types) are separated from class system. We still have classes in OCaml but they are not types. Classes are mainly to support inheritance. Let’s see some examples of objects.

```ocaml
# let s = object
  val mutable lifo = [0; 1; 2; 3]

  method push v =
    lifo <- v :: lifo

  method pop =
    match lifo with
    | [] -> None
    | hd :: tl ->
      lifo <- tl;
      Some hd
end;;
val s : < pop : int option; push : int -> unit > = <obj>
```
 
Here we define an object s of integer stack. First of all, the object s is of the object type < pop : int option; push : int -> unit >. Note that only methods appear in the type specification while fields are not. Besides, although the type of method push, int -> unit, looks like a regular function type, the type of method pop doesn’t. Because method calls always associate with an object, they may have no explicit arguments (but could have an implicit argument like this in C++/Java). Second, there is no constructors. We don’t really need a constructor because the object...end construct itself is an expression to create objects. On the other hand, we do need a way to initialize the fields of an object rather than hard-code values. To do that, we can define functions taking the advantage that object...end construct is an expression.
 
```ocaml
# let stack s = object
  val mutable lifo = s

  method push v =
    lifo <- v :: lifo

  method pop =
    match lifo with
    | [] -> None
    | hd :: tl ->
      lifo <- tl;
      Some hd
end;;
val stack : 'a list -> < pop : 'a option; push : 'a -> unit > = <fun>
# let s = stack [0; 1; 2; 3];;
val s : < pop : int option; push : int -> unit > = <obj>
# s#pop;;
- : int option = Some 0
# s#push 4;;
- : unit = ()
```
 
This function does the job of constructor while it is not part of an object or class. Recall that we can “update” an immutable record using the with syntax that actually returns a new record. Similarly, we can define immutable objects whose methods return new objects using the expression {< ... >} that produces a copy of the current object with specified fields updated.
 
```ocaml
# let immutable_stack s = object
  val lifo = s

  method push hd = {< lifo = hd :: lifo >}

  method pop =
    match lifo with
    | hd :: tl -> Some (hd, {< lifo = tl >})
    | [] -> None
end;;
val immutable_stack :
  'a list -> (< pop : ('a * 'b) option; push : 'a -> 'b > as 'b) = <fun>
```
 
##### Row Polymorphism
Since objects are values, we can define functions taking object arguments:
```ocaml
# let pop s = s#pop;;
val pop : < pop : 'a; .. > -> 'a = <fun>
```
This dummy function is simple but its type is very interesting. The type < pop : 'a; .. > means that an object of this type can be any object that has the pop method, and possibly some other unspecified methods. Heterogeneous objects that has no relations at all could be of the same open object type as long as they support the required methods. Clearly, it is different from subtyping. In OCaml, this is called row polymorphism while it is better known as duck typing. The name of duck typing refers to the duck test, according to James Whitcomb Riley:

When I see a bird that walks like a duck and swims like a duck and quacks like a duck, I call that bird a duck.

With duck typing, we only need to ensure that objects behave as required in a given context, rather than of a specific type. This is more flexible than the static class-based approach in C++/Java. In C++, duck typing is actually supported by templates. However, it is not fun to deal with incredibly long and cryptic compiling error messages with meta-programming. In Java, duck typing may be achieved with reflection, which is not easy either. Duck typing is fundamental to Smalltalk/Ruby, where behavior is triggered by messages sent between objects. The receiver checks its method list for a matching behavior. If no method matched, it produces a run-time error. Technically, a message with no matching method is not necessarily an error as the default behavior could be overridden. But we generally prefer finding errors early, right? Compared to them, OCaml’s row polymorphism is a neater and safer approach of duck typing.

##### Subtyping
Given the title of this section, you probably think that we will start talking about classes and inheritance. No, subtyping and inheritance are different concepts in OCaml. Inheritance is a syntactic relation between classes while subtyping is a semantic relation between types. An object type ot2 could be a subtype of ot1 if

It includes all of the methods of ot1
Each method of ot2 that is a method of ot1 is a subtype of the ot1 method
Let’s take the classic widget example without defining the class tree.

```ocaml
type widget = < draw : int -> int -> unit >
type button = < draw : int -> int -> unit; label : string >
```

A button has a method draw just like a widget, and an additional method label. Semantically, we expect a button to be a widget. To test it out, let’s define a helper function returning a button:

```ocaml
# let make_button s : button = object
  method draw x y = print_int x; print_int y (* dummy implementation *)
  method label = s
end;;
val make_button : string -> button = <fun>
```
 
In OCaml, subtyping is never implicit. We can use the coercion operator :> to explicitly perform subtyping.

```ocaml
# let make_widget s = (make_button s :> widget);;
val make_widget : string -> widget = <fun>
```
 
As indicated by the function type, make_widget returns a widget even though it is indeeds a button.

Both subtyping and row polymorphism allow us to apply some functions to objects of different types. In general, row polymorphism is preferred because it does not require explicit coercions and preserves more type information.

OOP is a big topic (check the size of The C++ Programming Language book). It is impossible to cover everything about the “O” of OCaml in a short post. Check out the manual for more details. I just hope that what we discussed is interesting enough getting you into learning and using OCaml in your next cool project!

