let give_me_a_three _ = 3;;

give_me_a_three (1/0);;

List.length [21; 23; 123; 22/0];;

let lazy_expr = lazy (1/0);;

lazy.force lazy_expr;;

let x = lazy (print_endline "hello");;

Lazy.force x;;

let expr = lazy (List.length [21; 23; 123; 22/0]);;

Lazy.force expr;;

type 'a inf_list = Cons of 'a * 'a inf_list Lazy.t;;

type 'a t = Cons of 'a * ('a t lazy_t);;

let rec from n = Cons (n, lazy (from (n + 1)))

let repeat x = Cons (x, lazy (repeat (x)))

let head (Cons (x, _)) = x

let tail (Cons (_, xs)) = Lazy.force xs

let take n s = 
let rec take' n (Cons (x, xs)) l =
  if m = 0 then List.rev l
  else take' (m - 1) (Lazy.force xs) (x :: l)
in
  take' n s []

let rec nth n (Cons (x, xs)) = 
  if n = 1 then x
  else nth (n - 1) (Lazy.force xs)

let rec map f (Cons (x, xs)) = 
  Cons (f x, lazy (map f (Lazy.force xs)))

let rec filter f (Cons (x, xs)) =
  Cons (f x, lazy (filter f (Lazy.force xs)))