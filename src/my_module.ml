module MyModule = struct
    let f1 x = 10 * x
    let f x y 4 * x + y
    let const1 = 100.32
    let msg1 = "hello world"
    let (+) x y = 10 * x + 3 * y
end;

MyModule.f1;;

MyModule.f;;

MyModule.(+);;

MyModule.f 90 10;;

List.map (MyModule.f 90) [10; 20; 30; 40; 50];;

MyModule.(1 + 2);;

let open MyModule in f1 20;;

f1 20;;

let open MyModule in List.map f1 [10;20;30;40;50];;

let open MyModule in let open List in map f1 [10;20;30;40;50];;

List.map f1 [10; 20; 30; 40; 50];;

#show MyModule;;

module M = MyModule;;

M.f 20 30;;

M.f1 50;;

M.(1 + 2);;

let x = let open M in 1 + 2;;

1 + 2;;

let open M in List.map f1 [10;20;30;40;50];;

let xs = let open M in List.map f1 [10;20;30;40;50];;

(** Open a module inside a function *)

let fun1 x = 
    let open MyModule in
    f 3 (f1 4 + f1 x);;

fun1 4;;

fun1 8;;

(** Module Alias inside a Function *)

let fun1' x = 
    let module A = MyModule in
    A.(f 3 ((f1 4) + (f1 x)));;

fun1' 3;;

fun1' 8;;

(** Open a Module Globally *)

open MyModule;;

f1 3;;

f1 10;;

List.map f1 [10;20;30;40;50];;

1 + 2;;

(* Let the file myModule.ml have the content: *)
let f1 x = 10 * x;;

let f x y = 4 * x + y;;

let const1 = 100.232;;

let msg1 = "hello world";;

let () = Printf.printf "Hello OCaml FP"

(* Load file *)

#use "myModule.ml";;

f1 4;;

f1 3;;

List.map (f 3) [4;5;6;7;8];;

(* Load file as module *)

#mod_use "myModule.ml";;

MyModule.f1;;

MyModule.f;;

MyModule.f 3 4;;

List.map (MyModule.f 3) [4;5;6;7;8];;

open MyModule;;

List.map (f 3) [4;5;6;7;8];;

(*** Loading Libraries Modules 
   It will load the library pcre, that can be installed with $ opam install pcre
***)

#use "topfind";;
#require "pcre";;

#show Pcre;;

Pcre.pmatch ~pat:"\\d+,\\d+" "1000,2323";;

Pcre.pmatch ~pat:"\\d+,\\d+" "sadasdas";;

let open Pcre in pmatch ~pat:"\\d+,\\d+" "1000,2323";;

let open Pcre in extract_all ~pat:"(\\d+), (\\d+)" "10023,2323";;

let open Pcre in
"23213,132345"
|> extract_all ~pat:"(\\d+),(\\d+)"
|> fun c -> c.(0);;

let open Pcre in
"23213,132345"
|> extract_all ~pat:"(\\d+),(\\d+)"
|> fun c -> c.(0)
|> fun c -> int_of_string c.(1), int_of_string c.(2);;

(* Including Modules *)
(* All functions of the native library module List will be included in the new module List that defines the functions take, drop and range. *)

module List = struct
    include List

    let rec take n xs =
        match (n, xs) with
        | (0, _) -> []
        | (_, []) -> []
        | (k, h::tl) -> k::(take (n - 1) tl)
    
    let rec drop n xs = 
        if n < 0 then failwith "n negative"
        else
            match (n, xs) with
            | (0, _) -> xs
            | (_, []) -> []
            | (k, h::tl) -> drop (k - 1) tl
    
    let rec range start stop step = 
        if start > stop
        then []
        else start::(range (start + step) stop step)
end;

List.range 100 500 10;;

List.range 100 500 10 |> List.take 10;;

List.range 100 500 10
|> List.filter (fun x -> x mod 5 = 0 && x mod 3 = 0);;
