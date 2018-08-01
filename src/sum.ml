(* 目的：将 0 到 n 之间的数字相加 
   前提条件：n 必须是自然数 
   sumTo 0 ==> 0
   sumTo 3 ==> 6
*)

let rec sumTo (n:int): int = 
    assert(n >= 0);
    match n with
    0 -> 0
    | n -> n + sumTo (n - 1);;

