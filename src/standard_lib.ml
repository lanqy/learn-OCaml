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