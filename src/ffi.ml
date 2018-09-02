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