(* Creating Libraries, Modules and Compiling to Bytecode or Machine Code *)

let pi = 3.141515

let byte_size = 8

let kbyte_size = 8192

let avg x y = (x +. y) / 2.0

let print_avg x y = print_float (avg x y)

let say_hello = print_string "Hello world OCaml"

let inc_int (x: int): int = x + 1;;

let is_zero x = 
    match x with
    | 0 -> true
    | _ -> false

let is_one = function
    | 1 -> true
    | _ -> false

(* Recursive Function *)
let rec factorial n =
    if n = 0
    then 1
    else n * factorial (n - 1);;

let rec factorial_1 n =
    match n with
    | 0 -> 1
    | 1 -> 1
    | _ -> n * factorial_1 (n - 1);;

module Week = struct
    type weekday = Mon | Tues | Wed | Thurs | Fri | Sun;;
    let from_weekday_to_string week =
        match week with
        | Mon -> "Monday"
        | Tues -> "Tuesday"
        | Wed -> "Wednesday"
        | Thurs -> "Thursday"
        | Fri -> "Friday"
        | Sun -> "Sunday"
end

module PhysicalConstants = struct
    let g = 9.81
    let gravity = 6.67384e-11
end

(* Loading File From interpreter/ toplevel. *)

(**********************
#use "example.ml" ;;
pi;;
is_zero 10;;
is_zero 0;;
factorial 5;;
PhysicalConstants.gravity;;
Week.Mon;;
Week.Tues;;
Week.from_weekday_to_string;;
Week.from_weekday_to_string Week.Tues;;
open Week;;
Tues;;
List.map from_weekday_to_string [Mon;Sun;Tues];;
open PhysicalConstants;;
g;;
gravity;;

**********************)

(* Compile Module to Bytecode *)
(**********************

ocamlc -c example.ml

# Test file types
file example.cmi
file example.cmo

# Check Module Type signature
ocamlc -i -c example.ml

# Export Module signature
ocamlc -i -c example.ml > example.mli

**********************)

(* Loading compiled bytecode into toplevel: $ ocaml *)
(**********************
Example.avg 23.2 232.22;;

Example.Week.from_weekday_to_string Example.Week.Sun;;
Sun;;
Mon;;
List.map from_weekday_to_string [Mon;Sun;Tues];;
Example.PhysicalConstants.g;;
Example.PhysicalConstants.gravity;;
Example.factorial 3;;
Example.factorial 10;;
open Example;;
PhysicalConstants.g;;
PhysicalConstants.gravity;;
**********************)

(* Compile to Library *)
(**********************
ocamlc -c example.ml
ocamlc -a example.cmo -o example.cma

file example.cma

**********************)

(* Loading example.cma *)
(**********************
#load "example.cma"
Example.PhysicalConstants.g;;
file example.cmx
**********************)
