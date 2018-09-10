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