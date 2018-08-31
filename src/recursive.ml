type intlist = Nil | Cons of (int * intlist)

let rec length (alist: intlist): int =
    match alist with
    | Nil -> 0
    | Cons(h, t) -> 1 + (length t)

let is_empty (alist: intlist): bool =
    match alist with
    | Nil -> true
    | Cons(_, _) -> false

let rec sum (alist: intlist): int =
    match alist with
    | Nil -> failwith "Error empty list"
    | Cons (a, Nil) -> a
    | Cons (h, rmain) -> h + sum remain

let rec product (alist: intlist): int = 
    match alist with
    | Nil -> failwith "Error empty list"
    | Cons (a, Nil) -> a
    | Cons (h, remain) -> h * product remain

let rec head (alist: intlist): int = 
    match alist with
    | Nil -> failwith "Error empty list"
    | Cons (a, _) -> a

let rec last (alist: intlist): int =
    match alist with
    | Nil -> failwith "Error empty list"
    | Cons (a, Nil) -> a
    | Cons (h, remain) -> last remain

let rec map f alist = 
    match alist with
    | Nil -> Nil
    | Cons (e, remain) -> Cons(f e, map f remain)

let rec iter (f: int -> unit) (alist: intlist): unit =
    match alist with
    | Nil -> failwith "Error empty list"
    | Cons(a, Nil) -> f a
    | Cons(hd, tl) -> f hd; iter f tl

let rec filter f alist = 
    match alist with
    | Nil -> Nil
    | Cons (e, remain) ->
            if (f e)
            then Cons(e, filter f remain)
            else filter f remain

let rec foldl1 func alist = 
    match alist with
    | Nil -> failwith "Error empty list"
    | Cons (a, Nil) -> a
    | Cons (hd, tl) -> func hd (foldl func tl)

let rec foldl func acc alist =
    match alist with
    | Nil -> acc
    | Cons (hd, tl) -> func hd (foldl func acc tl)

let rec nth alist n = 
    match (alist, n) with
    | (Nil, _) -> failwith "Empty list"
    | (Cons(h, _), 1) -> h
    | (Cons(hd, tl), k) -> nth tl (k - 1)

let rec take n alist =
    match (n, alist) with
    | (_, Nil) -> Nil
    | (0, _) -> Nil
    | (k, Cons(hd, tl)) -> Cons(hd, take (k - 1) tl)

let rec append ((list1: intlist), (list2:intlist)): intlist =
    match list1 with
    | Nil -> list2
    | Cons(hd, tl) -> Cons(hd, append((tl, list2)))

let rec reverse(list: intlist): intlist =
    match list with
    Nil -> Nil
    | Cons(hd, tl) -> append(reverse(tl), Cons(hd, Nil))
    
