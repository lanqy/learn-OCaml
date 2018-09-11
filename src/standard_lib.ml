(* Standard (Native) Library Modules *)

(* List *)

(* Cons and Nil *)
[] : 'a list                    (*     Nil *)
:: : 'a -> 'a list -> 'a list   (* :: Cons *)

23::[];;
12::23::[];;
34::12::23[];;
1::[2;34;55];;
[]::[];;
[]::[]::[];

(* List Functions *)

(* Concatenate Lists *)
(@);;
[1;2;3;4;5] @ [5;6;8];;

(* First element of a list / head of the list *)
List.hd [1;2;3;4;5;6;7;8;9];;

(* Remove first Element of a list/ tail of the list *)
List.tl [1;2;3;4;5;6;7;8;9];;

sum [1;2;3;4;5;6];;

(* Reverse List *)
List.rev [1;2;3;4];;

(* Pick Element *)
List.nth [0;1;2;3;4] 0;;
List.nth [0;1;2;3;4] 1;;
List.nth [0;1;2;3;4] 2;;
List.nth [0;1;2;3;4] 3;;

(* List Lenght *)

List.length [0;1;2;3;4];;
List.length [0;1;2];;

(* Combine - Equivalent to Haskell zip *)
List.combine;;

List.combine [1;2;3] ['a'; 'b', 'c'];;
List.combine [1;2;3;5] ['a';'b';'c'];;

(* Split - Equivalent to Haskell unzip *)

List.split [(1,'a');(2, 'b'); (3, 'c')];;

(* Equivalent to Haskell (++) *)

List.append [0;2;3;5;6] [1;2;6];;

(* Find *)

List.find (fun x -> x < 10) [1;2;3;4;45];;
List.find (fun x -> x > 10) [1;2;3;4;45];;

List.find (fun x -> x > 100) [1;2;3;4;5;6];;

List.find_alll (fun x -> x > 10) [-10;20;3;12;100;4;35];;

List.exists;;
List.exists ((==) 10) [1;2;30;50;3];;
List.exists ((==) 10) [1;2;30;10;50;3];;
List.for_all2 (>=) [1;2;3] [2;3;4];;
List.exists2 (<) [1;2;3] [1;2;3];;
List.exists2 (<) [1;2;0] [1;2;3];;

List.exists2 (<) [1;2;0] [1;2];;

List.assoc 3 [(0, "a"); (1, "b");(2, "c");(3,"d")];;
List.assoc 0 [(0, "a"); (1, "b"); (2, "c"); (3, "d")];;
List.assoc 5 [(0, "a"); (1, "b"); (2, "c"); (3, "d")];;

List.mem_assoc 5 [(0, "a"); (1, "b"); (2, "c"); (3, "d")];;
List.mem_assoc 3 [(0, "a"); (1, "b"); (2, "c"); (3, "d")];;
List.mem_assoc 2 [(0, "a"); (1, "b"); (2, "c"); (3, "d")];;

List.remove_assoc 0 [0,"a"; 1, "b"; 2, "c"; 3, "d"];;

(* Partition *)

List.partition ;;

List.partition (fun x -> x > 10) [-10; 20; 3; 12; 100; 4; 35];;

List.flatten;;

List.flatten [[1];[2; 4]; [6; 90; 100]; []];;

(* MAP *)
(* --------------- *)

List.map;;
List.map (( *) 10) [-10; 20; 5; 50; 100; 3];;
List.map ((+) 10) [-10; 20; 5; 50; 100; 3];;

let f x = 10 * x - 5;;split
List.map f [-10; 20; 5; 50; 100; 3];;
List.map (fun x -> 10.5 *. x -. 4.) [2.; 3.; 5.; 10.; 20.];;

(*      MAPI        *)
(*------------------*)
List.mapi;;
List.mapi (fun index element -> index, element) [17.; 27.5; 48.5; 101.; 206.];;

(* MAP2 / Haskell zipWith *)
List.map2;;
List.map2 (+) [10; 20; 30; 100] [15; 35; 25; 80];;
List.map2 ( *) [10; 20; 30; 100] [15; 35; 25; 80];;
List.map2 (fun x y -> (x, y)) [10; 20; 30; 100] [15; 35; 25; 80];;
List.map2 (fun x y -> (x, y)) [10; 20; 30; 100] [15; 35; 25];;

let fxy x y = 10 * x - 4 * y;;
List.map2 fxy [10; 20; 30; 100] [15; 35; 25; 80];;

(*      FILTER      *)
(*------------------*)
List.filter;;
List.filter ((<) 10) [-10; 20; 5; 50; 100; 3];;

(*  FOLFR and FOLDL - Equivalent to Haskell foldr and foldl
 *   The fold functions are known as reduce. (i.e Python reduce (left fold))
 *)
List.fold_right;;
(*
        f x y = x + 10* y
        foldr  f [1; 2; 3; 5; 6] 0

    Evaluation:

    (f 1 (f 2 (f 3  (f 5 (f 6 0)))))    f 6   0  = 6 + 10*0    =     6
    (f 1 (f 2 (f 3  (f 5 6))))          f 5   6  = 5 + 10*6    =     65
    (f 1 (f 2 (f 3  65)))               f 3  65  = 3 + 10*65   =    653
    (f 1 (f 2 653))                     f 2 653  = 2 + 10*653  =    6532
    (f 1 6532)                          f 1 6532 = 1 + 10*6532 =   65321
    65321
    *)

List.fold_right (fun x y -> x + 10 * y) [1;2;3;4;5;6] 0;;
List.fold_left;;
(*
        f x y = 10*x + y
        flodl f 0 [1; 2; 3; 5; 6]

    Evaluation:

    (f (f (f ( f (f 0 1) 2 ) 3) 5) 6)     f 0    1 = 10*0    + 1   =    1
    (f (f (f ( f 1 2 ) 3) 5) 6)           f 1    2 = 10*1    + 2   =   12
    (f (f (f 12 3) 5) 6)                  f 12   3 = 10*12   + 3   =   123
    (f (f 123 5) 6)                       f 123  5 = 10*123  + 5   =  1235
    (f 1235 6)                            f 1235 6 = 10*1235 + 5   = 12356
    12356
    *)
List.fold_left (fun x y -> 10 * x + y) 0 [1;2;3;4;5;6];;

List.fold_left (+) 0 [1;2;3;4;5;6];;
List.fold_left ( *) 1 [1;2;3;4;5];;

(*    ITER / MAP Non Pure Functions  *)
(*-----------------------------------*)

List.iter;;
List.iter (Printf.printf "= %d \n") [-10; 3; 100; 50; 5; 20];;

(* ITERI    *)

List.iteri;;
List.iteri (Printf.printf "idendx = %d element = %d\n") [-10;3;100;50;5;20];;

(* ITER2    *)

List.iter2;;
List.iter2 (Printf.printf "%s = %d\n") ["x"; "y"; "z"] [1;2;3];;


(* Array *)
[|10; 2; 100; 25; 0; 1|];;
let a = [|10; 2; 10; 25; 100; 0; 1|];;
a.(0);;
a.(1);;
a.(4);;
a.(10);;

Array.length;;
Array.length a;;
Array.map;;
Array.map (fun x -> x * 2 + 1) a;;
a.(0) <- 56;;
a;;
a.(5) <- 567;;
(*  Maps a function that takes the index of element
    as first argument and then the element as second
    argument.

    f(index, element)
*)
Array.mapi;;
Array.mapi (fun idx e -> idx, e) [|56; 2; 10; 25; 100; 567; 1|];;
Array.to_list;;
Array.to_list a;;
Array.get;;
Array.get a 0;;
Array.get a 20;;

let a = [|56; 2; 10; 100; 567; 1|];;
Array.set;;
Array.set a 0 15;;
Array.set a 4 235;;

Array.fold_right;;
Array.fold_right (+) [|56; 2; 10; 25; 100; 567; 1|] 0;;

Array.fold_left;;
Array.fold_left (+) 0 [|56; 2; 10; 25; 100; 567; 1|];;
Array.iter (Printf.printf "x = %d\n") [|56; 2; 10; 25; 100; 567; 1|];;
(*  Applies a function that takes the index of element
    as first argument and then the element as second
    argument.

    f(index, element)
*)
Array.iteri;;
Array.iteri (Printf.printf "x[%d] = %d\n") [|56; 2; 10; 25; 100; 567; 1|];;

Array.init;;
Array.init 10 (fun x -> 5. *. float_of_int x);;
Array.init 10 (fun x -> 5 * x + 10);;

Array.make_matrix;;
Array.make_matrix;;
Array.make_matrix 2 3 1;;

(* String *)

(* Char Module *)

Char.chr;;

(* Acii code to Char *)
Char.chr 99;;

(* Char to Ascii Code*)
Char.code 'a';;
Char.code;;

(* Upper Case / Lower Case *)

Char.uppercase 'c';;
Char.lowercase 'A';;

(* String Module *)

(* Length of String *)
String.length "Hello world";;

(* Concatenate Strings *)
String.concat "\n" ["Hello"; "World"; "OCaml"];;
"Hello " ^ " World" ^ " OCaml";;

(* Uppercase / Lowercase *)
String.capitalize_ascii "hello world";;
String.lowercase_ascii "HELLO WORLD";;

(* Get Character at position *)
String.get;;
String.get "Hello world" 0;;
String.get "Hello world" 1;;

List.map (String.get "Buffalo") [0; 1; 2; 3; 4; 5; 6];;

let str = "My string";;
str.[0];;
str.[5];;

(* Setting Characters *)
let str = "My string";;
(* deprecated: String.set use Bytes.set instead. *)

str.[0] <- 'H';; (* Bytes.set str 0 'H';; *)
str.[1] <- 'e';; (* Bytes.set str 1 'e';; *)

(* Contains test if character is in the string *)
String.contains;;
String.contains "hello" 'c';;
String.contains "hello" 'h';;

(* Map Characters *)
String.map;;
let encode key chr = Char.chr ((Char.code chr) - key);;
let decode key chr = Char.chr (Char.code chr + key);;

let str = "Hello world";;
String.map (encode 13) str;;
String.map (decode 13) ";X__b\019jbe_W";;

(* Str Module *)
(* When in the toploop interactive shell *)
#load "str.cma"

(* Compile String to a regular expression*)
Str.regexp;;
Str.regexp ",";;

(* Split String *)

Str.split;;
Str.split (Str.regexp ",") "23.232,9823,\"Ocaml Haskell FP\"";;
Str.split (Str.regexp "[,|;]") "23.232,9823,\"Ocaml Haskell FP\"";;
Str.split (Str.regexp "[ ]") "23.232 9823 Ocaml Haskell FP 400";;
Str.string_before;;
Str.string_before "Hello world ocaml" 3;;
Str.string_before "Hello world ocaml" 11;;
Str.string_after "Hello world ocaml" 11;;
Str.split (Str.regexp "[ ]") "23.232 9823 Ocaml Haskell FP 400";;

(* Buffer Module *)
Buffer.create;;
Buffer.contents;;
Buffer.add_char;;
Buffer.add_bytes;;
Buffer.add_string;;
Buffer.reset;;
let b = Buffer.create 0;;
Buffer.contents b;;
Buffer.add_string b "OCaml fp rocks ! OCaml is amazing";;
Buffer.contents b;;
Buffer.add_string b " - OCaml is strict FP";;
Buffer.contents b;;

Buffer.length b;;

Buffer.reset b;;
Buffer.contents b;;


let c = Buffer.create 0;;
Buffer.add_char c 'o';;
Buffer.add_char c 'c';;
Buffer.add_char c 'a';;
Buffer.add_char c 'm';;
Buffer.add_char c 'l';;

Buffer.contents c;;

print_string (Buffer.contents c);;
Buffer.nth c 0;;

Buffer.nth c 0;;
Buffer.nth c 1;;
Buffer.nth c 2;;
Buffer.nth c 3;;
Buffer.nth c 4;;
List.map (Buffer.nth c) [0;1;2;3;4];;
let s = "hindler milner type system";;
let b = Buffer.create 0;;
Buffer.add_substring;;
Buffer.add_substring b s 0 4;;
Buffer.contents b;;
Buffer.add_substring b s 4 5;;
Buffer.contents b;;
Buffer.add_substring b s 6 10;;
Buffer.contents b;;
Buffer.sub;;

let c = Buffer.create 0;;
Buffer.add_string c "OCaml is almost fast as C";;
Buffer.sub c 0 1;;
Buffer.sub c 0 5;;
Buffer.sub c 0 10;;
Buffer.sub c 5 15;;

(* String Processing *)
(* Splitting a string into characters. *)
let s = "p2p peer to peer connection";;
let arr = Array.make;;
let arr = Array.make (String.length s) '\000';;
for i = 0 to (String.length s - 1) do
    arr.(i) <- s.[i]
done;;

arr;;

let str2chars s = 
    let arr = Array.make (String.length s) '\000' in
    for i = 0 to (String.length s - 1) do
        arr.(i) <- s.[i]
    done;
    arr;;

str2chars "fox";;

str2chars "fox" |> Array.map Char.code;;

let str2chars_ s = 
    let arr = Array.make (String.length s) '\000' in
    for i = 0 to (String.length s - 1) do
        arr.[i] <- s.[i]
    done;
    Array.to_list arr;;

str2chars_ "UNIX";;
str2chars_ "UNIX" |> List.map Char.code;;

(* Functional Approach *)

let str2chars s = 
    let n = String.length s in
    let rec aux i alist = 
        if i = 0
        then []
        else s.[n - i] :: (aux (i - 1) alist)
    in aux n [];;

str2chars "UNIX";;
str2chars "UNIX" |> List.map Char.code;;

(* Extract Digits *)
let digit_of_char c =
    match c with
    | '0' -> 0
    | '1' -> 1
    | '2' -> 2
    | '3' -> 3
    | '4' -> 4
    | '5' -> 5
    | '6' -> 6
    | '7' -> 7
    | '8' -> 8
    | '9' -> 9
    | _ -> failwith "Not a digit";;

str2chars "12345" |> List.map digit_of_char;;
str2chars "12334x" |> List.map digit_of_char;;
let str2digits s = str2chars s |> List.map digit_of_char;;
str2digits "1234";;

(* Join Chars *)
let cs = ['O';'C';'a';'m';'l'];;
Buffer.add_char;;
List.iter;;
List.iter (Buffer.add_char b) cs;;
Buffer.contents b;;
let chars2str cs =
    let b = Buffer.create 0 in
    List.iter (Buffer.add_char b) cs;
    Buffer.contents b;;

chars2str ['O';'C';'a';'m';'l'];;

(* Strip Left Chars *)
let trim chars s =
    let n = String.length s in
    let b = Buffer.create 0 in
    for i = 0 to n - 1 do
        if List.mem s.[i] chars
            then ()
            else Buffer.add_char b s.[i]
    done;
    Buffer.contents b;;

trim ['-'; '.']  "-.--.--.....-trim chars---...----.-.-" ;;

(* Sys *)
(* Command Line Arguments *)
Sys.argv;;

(* Current Directory *)
Sys.getcwd;;
Sys.getcwd();;

(* Change Current Directory *)
Sys.chdir;;
Sys.chdir "/";;
Sys.getcwd();;

(* List directory *)
Sys.readdir;;
Sys.readdir("/");;

(* Test if is directory *)
Sys.is_directory "/etc";;
Sys.is_directory "/etca";;
Sys.is_directory "/etc/fstab";;

(* Test if File exists *)
Sys.file_exists;;
Sys.file_exists "/etc";;
Sys.file_exists "/etca";;

(* Execute shell command and return exit code
     *   0    For success
     *  not 0 For failure
     *)

Sys.commond;;
Sys.commond "uname -a";;
Sys.commond "nam";;

(* Constants and Flags *)

(* Machine Word Size in bits *)
Sys.word_size;;

(* Machine Endianess *)
Sys.big_endian;;

(*
     *  For Linux/BSD or OSX  --> "Unix"
     *  Windows               --> "Win32"
    *)

Sys.os_type;;

(*  Maximum length of strings and byte sequences. =
     *   =~  16 MB
     *)

Sys.max_string_length;;

(* Extra Example *)
let (|>) x f = f x;;
let (|<) f x = f x;;
Sys.chdir "/boot";;
Sys.readdir ".";;

(* List only directories *)
"." |> Sys.readdir |> Array.to_list |> List.filter Sys.is_directory;;

(* List only files *)
"." |> Sys.readdir |> Array.to_list |> List.filter (fun d -> not <| Sys.is_directory d);;

(* Filename *)
(* It provides file name combinators. *)
#show Filename;;

(** Note:  Directory Separtor, on Windows it is (\), but is written 
in Ocaml as (\\) , but you can also use Unix path conventions, "/" 
the root is translater as C:\\ and "/" as \\ and "." as the current
directory.   
*)

Filename.dir_sep;;

(** Concat Concat File Paths *)
Filename.concat "/home/dummy/Document/" "blueprints.doc";;

List.map (Filename.concat "/opt") ["dir1";"dir2";"dir3"];;

let concat_paths pathlist = List.fold_right Filename.concat pathlist "";;
concat_paths ["/"; "etc"; "fstab"];;

(** Get the file name without path to file *)
Filename.basename "/etc/fstab";;



(** Get the path where is the file or directory*)
Filename.dirname "/home/tux/windows/ocamlapidoc/index.html";;
Filename.dirname "/home/tux/windows/ocamlapidoc"

(** Test if file ends with extension *)
Filename.check_suffix "test.ml" "ml";;
Filename.check_suffix "test.ml" "sh";;

"/etc"
|> Sys.readdir
|> Array.to_list
|> List.filter (fun x -> Filename.check_suffix x "conf");;

(* You can can create combinators to enhance the composability, 
   reusability and modularity   
*)
let listdir path = Sys.readdir path |> Array.to_list;;
let is_file_type ext fname = Filename.check_suffix fname ext;;
listdir "/etc" |> List.filter (is_file_type ".conf");;

List.map Filename.chop_extension ["file.ml"; "filex.hs";"file2.py"];;
Filename.chop_suffix "archive.tar.gz" ".tar.gz";;
Filename.chop_suffix "archive.tar.gz" ".tar.bz2";;
Filename.quote "separated file name is not good.txt";;
Filename.quote "separated file name is not good.txt" |> print_endline;;