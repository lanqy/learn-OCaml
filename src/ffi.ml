(* opam install ctypes ctypes-foreign *)

#require "ctypes";;
#require "ctypes.foreign";;
open Foreign;;
open PosixTypes;;
open Ctypes;;

int puts(const char *s);

let puts = foreign "puts" (string @-> returning int);;

puts "hello world";;

int chdir (const char *path);

let chdir_ = foreign "chdir" (string @-> returning int);;

chdir_ "/";;

chdir_ "/wrong directory" ;;

let chdir path =
  let _ chdir_ path in ();;

chdir "/";;

chdir "/wrong directory";;

char *getcwd(char *buf, size_t size);

let getcwd = foreign "getcwd" (void @-> returning string);;

getcwd ();;

int system(const char *command);;

let system = foreign "system" (string @-> returning int);;

system "uname -a" ;;

system "pwd" ;;

system "wrong command" ;;

unsigned int sleep(unsiged int seconds);

let sleeps = foreign "sleep" (int @-> returning int);;

sleep1 3;;

let sleep2 = foreign "sleep" (int @-> returning void);;

sleep2 4;;

int gethostname(char *name, size_t len);

let get_host = foreign "gethostname" (ptr char @-> int @-> returning int);;

let host_name_max =  64;;

let s = allocate_n char ~count:host_name_max;;

get_host s host_name_max;;

string_from_ptr s ~length:host_name_max;;

coerce (ptr char) string s;;

let get_host = foreign "gethostname" (ptr char @-> int @-> returning int);;

let gethostname () =
  let host_name_max = 64 in
  let s = allocate_n char ~count:host_name_max in
  let _ = get_host s host_name_max in
  coerce (ptr char) string s;;

gethostname ();;

#include <math.h>

double cbrt(double x);;

let cbrt = foreign "cbrt" (double @-> returning double);;

List.map cbrt [1.; 8.; 64; 125.; 216.; 1000.];;

include <stdio.h>

FILE *popen(cons char *command, const char *type);

require "ctypes";;
require "ctypes.foreign";;

open PosixTypes;;
open Ctypes;;
open Foreign;;

let is_null_ptr pointer_type pointer =
  ptr_compare pointer (from_voidp pointer_type null) = 0;;

let fgets = 
  foreign "fgets" (ptr char @-> int @->ptr int @-> returning (ptr char));;

let popen_ = 
  foreign "popen" (string @-> string @-> returning (ptr int));;

let make_null_ptr ptrtype = from_voidp ptrtype null;;

exception Exit_loop;;

let read_fd file_descriptor =   
  let buffsize = 4000 in (* Buffer of 4000 bytes *)
  let v = Pervasives.ref (from_voidp char null) in
  let b = Buffer.create buffsize in
  let s = allocate_n char ~count:buffsize in

  let closure () =
    try while true do
      v := fgets s (buffsize - 1) file_descriptor;
      if is_null_ptr char !v then raise Exit_loop;
      Buffer.add_string b (string_of_ptrchar s);
    done
    with Exit_loop -> ();
  in closure (); Buffer.contents b;;

let popen command = read_fd (popen_ command "r");;

popen "ls";;

popen "ls" |> print_string;;

popen "pwd" |> print_string;;


let gsl_lib = Dl.dlopen ~filename:"libgsl.so" ~flags:[Dl.RTLD_LAZY; Dl.RTLD_GLOBAL];;

let gsl_sf_bessel_JO = foreign ~from:gsl_lib "gsl_sf_bessel_JO" (double @-> returning double);;

gsl_sf_bessel_JO 5.0;;

List.map gsl_sf_bessel_JO [1.0; 10.0;100.0;1000.0];;

let gsl_poly_eval_ = foreign ~from:gsl_lib "gsl_poly_eval" (ptr double @-> int @-> double @-> returning double);;

let poly = CArray.of_list double [1. ; 2. ; 3.];;

CArray.start poly;;

gsl_poly_eval_ (CArray.start poly) 3 5.0;;

gsl_poly_eval_ (CArray.start poly) 3 7.0;;

gsl_poly_eval_ (CArray.start poly) 3 9.0;;

let gsl_poly_val poly x =
  let p = CArray.of_list double poly in gsl_poly_eval_ (CArray.start p) (List.length poly) x;;

List.map (gsl_poly_val [1.;2.;3.]) [5.0; 7.0; 9.0];;

let mypoly = gsl_poly_val [1.;2.; 3.];;

List.map mypoly [5.0; 7.0; 9.0];;


let pylib = Dl.dlopen ~filename: "libpython2.7.so" ~flags:[Dl.RTLD_LAZY; Dl.RTLD_GLOBAL];;

let py_int = foreign "Py_Initialize" ~from:pylib (void @-> returning void);;

py_init ();;

let py_getpath = foreign "Py_GetPath" ~from:pylib (void @-> returning string);;

py_getpath ();;

let py_getVersion = foreign "Py_GetVersion" ~from:pylib (void @-> returning string);;

py_getVersion ();;

let py_GetPlatform = foreign "Py_GetPlatform" ~from:pylib (void @-> returning string);;

py_GetPlatform ();;

let pyRunSimpleString = foreign "PyRun_SimpleString" ~from:pylib (string @-> returning int);;

pyRunSimpleString "print 'hello world'";;

pyRunSimpleString "f = lambda x: 10.5 * x - 4";;

pyRunSimpleString "print (map(f, [1,2,3,4,5,6,7]))";;

pyRunSimpleString "import sys; print sys.executable";;

let py_finalize = foreign "Py_Finalize" ~from:pylib (void @-> returning void);;

py_finalize ();;

let open List in map;;

let open List in map (fun x -> x + 1) [1;2;3;4;5];;

map (fun x -> x + 1) [1;2;3;4;5];;

let open Array in map;;

let open Array in map (fun x -> x + 1) [|1;2;3;4;5|];;

List.(map);;

Array.(map);;

List.(map (fun x -> x + 1) [1;2;3;4;5]);;

Array.(map (fun x -> x + 1) [|1;2;3;4;5|]);;

module L = List;;
L.map;;

L.map ((+) 1) [1;2;3;4;5;6];;

let open L in map;;

let open L in map (fun x -> x + 1) [1;2;3;4;5];;

let dummy_function xs ys = 
  let open List in
  map (fun (x, y) -> 3 * x + 5 * y) (L.combine xs ys);;

open List;;

map;;

find;;

filter;;

map (fun x -> x + 1) [1;2;3;4;5];;

map ((+) 1) [1;2;3;4;5;6];;

map ((+) 1) [1;2;3;4;5] |> find (fun x -> x > 2);;