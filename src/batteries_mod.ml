(********

opam install batteries
#require "batteries";;
open Batteries;;

#show List;;

(** Function Signatures *)
#show BatList;;
module List = BatList;;

 (* Head, Tail and Last *)
 List.hd [1;2;3;4;5;6;7;8;9;10];;
 List.tl [1;2;3;4;5;6;7;8;9;10];;
 List.first [1;2;3;4;5;6;7;8;9;10];;
 List.last [1;2;3;4;5;6;7;8;9;10];;

(* Nth Element *)
List.at [1;2;3;4;5;6;7;8;9;10] 0;;
List.at [1;2;3;4;5;6;7;8;9;10] 1;;
List.map (List.at [1;2;3;4;5;6;7;8;9;10] [0;5;2]);;

(* Min and Max *)
List.max [1;2;3;4;5;6];;
List.min [1;2;3;4;5;6];;

(* Remove an element *)
List.remove ['x';'d';'a';'i';'o';'a'] 'a';;
List.remove_all ['x';'d';'a';'i';'o';'a'] 'a';;
List.remove_at 0 ['x';'d';'a';'i';'o';'a'];;

 (* Removes the first element that satisfies the predicate *)
List.remove_if (fun x -> x mod 2 = 0) [1;2;4;5;10;11];;

(* Sum *)
List.sum;;
List.sum [1;2;3;4;5;6];;

(* Sum of floats *)
List.fsum;;
List.fsum [1.;2.3323;3.1415;10.];;

(* Map / Iter *)
List.map;;
List.map (fun x -> 10 * x + 3) [1;2;3;4;5];;
List.iter;;

List.iter (Printf.printf "= %d\n") [1;2;3;4];;

(* Take and Drop *)
List.take 3 [1;3;4;5;6;7];;
List.take 12 [1;3;4;5;6;7];;
List.drop 4 [1;3;4;5;6;7];;
List.drop 14 [1;3;4;5;6;7];;

(* Take while *)
List.takewhile (fun x -> x < 5) [1;2;3;4;5;6;7;8;9;10];;

(* Drop while *)
List.dropwhile (fun x -> x < 5) [1;2;3;4;5;6;7;8;9;10];;

List.partition (fun x -> x < 5) [1;2;3;4;5;6;7;8;9;10];;

*********)