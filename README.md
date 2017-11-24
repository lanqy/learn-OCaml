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
