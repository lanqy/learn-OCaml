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
    | Cons (h, remain) -> h + sum remain

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

let rec foldl func acc alist =
    match alist with
    | Nil -> acc
    | Cons (hd, tl) -> func hd (foldl func acc tl)

let rec foldl1 func alist = 
    match alist with
    | Nil -> failwith "Error empty list"
    | Cons (a, Nil) -> a
    | Cons (hd, tl) -> func hd (foldl func tl)


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
    
let l1 = Nil
let l2 = Cons(1, Nil)
let l3 = Cons(2, l2)
let l4 = Cons(3,l3)
let l5 = Cons(1, Cons(2, Cons(3, Cons(4, Cons(5, Nil)))))

List.map length [l1; l2; l3; l4; l5]

List.map is_empty [l1; l2; l3; l4; l5]

sum l1

sum l2

product l1

product l2

List.map head [l2; l3; l4; l5]

last l1

last l3

map ((+) 1) Nil

map ((+) 1) (Cons(1, Nil))

map ((+) 1) (Cons(1, Cons(3, Cons(4, Cons(5, Nil)))))

append(l4, l5)

reverse l5

let even x = x mod 2 == 0

filter even l5

l5

nth l5 2

nth l5 1

foldl1 (+) l5

foldl1 (fun x y -> x * y) l5

foldl1 (fun x y -> x + 10 * y) l5

foldl (+) 0 l5

foldl (fun x y -> x * y) 2 l5

take 0 l5

take 1 l5

iter (Printf.printf "= %d\n") l5


type fileTree =
    | File of string
    | Folder of string * fileTree list;;

let neg f x =  not (f x);;

let relpath p str = p ^ "/" ^ str;;

let scand_dir path =
    Sys.readdir path
    |> Array.to_list;;

let is_dir_relpath path rel = 
    Sys.is_directory (relpath path rel);;

let rec walkdir path =
    let files = path
    |> scand_dir
    |> List.filter @@ neg (is_dir_relpath path)
    |> List.map (fun x -> File x) in

    let dirs = path
    |> scand_dir
    |> List.filter (is_dir_relpath path)
    |> List.map (fun x -> Folder (x, walkdir (relpath path x))) in
    
    dirs @ files;;

walkdir "/Applications";;