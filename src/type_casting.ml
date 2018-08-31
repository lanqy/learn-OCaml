(* 整型转浮点型 *)
float_of_int 2323;;

(* 字符串转浮点型 *)
float_of_string "100.04523";;

(* 字符串转整型 *)
int_of_string "900000";;

(* 浮点型转整型 *)
int_of_float 100.04523;;

let x = [20;230;10;40;50];;

List.map float_of_int x;;

(* 数组转列表 *)
Array.of_list x;; 

 (* 列表转数组 *)
Array.to_list [|20;230;10;40;50|];;

(* 布尔值转字符串 *)
string_of_bool true;;

(* 整型转字符串 *)
string_of_int 11000;;

string_of_float 23.444;;
