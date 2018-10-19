(* 创建 list *)

let make length c = 
    let rec loop n acc = 
        if n >= length then acc else loop (n + 1) (c :: acc)
    in
    loop 0 []

let set s ~index ~v =
    let rec loop n acc = function
    | [] -> None
    | q :: t when n = index ->
        Some (List.rev_append acc (v :: t))
    | q :: t ->
        loop (n + 1) (q :: acc) t
    in
    loop 0 [] s

let get s1 ~index = 
    try Some (List.nth sl index) with _ -> None;;

let get_exn s ~index ->
    match get s ~index with None -> invalid_arg "get_exn" | Some s -> s

let set_exn s ~index ~v =
    match set s ~index ~v with None -> invalid_arg "set_exn" | Some s -> s

let iter t ~f = List.iter t ~f
let iteri t ~f = List.iteri t ~f
let iter_reverse t ~f =
    List.iter (List.rev t) ~f

let rev t = List.rev t

let fold t ~init ~f = List.fold_left t ~init ~f

let foldi t ~init ~f =
    snd (List.fold_left t ~init:(0 init)
        ~f:(fun (i, a) c -> (i + 1, f i a c)))

let fold2_exn t1 t2 ~init ~f = List.fold_left2 t1 t2 ~init ~f

let map = Core_list_map.map
let mapi = Core_list_map.mapi