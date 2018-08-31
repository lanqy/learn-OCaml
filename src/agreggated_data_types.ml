type agg = Agg of int * string

let a = Agg (1, "hi");;

a;;


type shape = 
    Rect of float * float (* width * lenght *)
    | Circle of float (* radius *)
    | Triang of float * float * float (* a * b * c *)

let pictures = [Rect (3.0, 4.0); Circle 5.0; Triang (5.0, 5.0, 5.0)]

let perimiter s = 
    match s with
        Rect (a, b) -> 2.0 *. (a +. b)
        | Circle r -> 2.0 *.3.1415 *. r
        | Triang (a, b, c) -> a +. b +. c

perimiter (Rect (3.0, 4.0));;

perimiter (Circle 3.0);;

perimiter (Triang (2.0, 3.0, 4.0));;

List.map perimiter pictures;;