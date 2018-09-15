(* opam instal lwt cohttp  *)

(* Running as script *)
ocaml curl.ml http://httpbin.org/xml

(* Compiling to bytecode *)
(* To compile the file the toplevel directives #use, #mod_use, #load must be removed *)
ocamlfind ocamlc -o curl.byte curl.ml -package lwt,cohttp -linkpkg

(* It is possible to remove the directives without change the file by using the -pp option to invoke the preprocessor. To see the byte compiler messages use the option "-verbose". *)
ocamlfind ocamlc -o curl.ml package url,lwt,lwt.unix,cohttp.lwt -linkpkg -pp 'sed "s/^#.*;;//"'

file curl.byte;;

./curl.byte http://httpbin.org/status/418

(* Compiling to Native Code *)
ocamlfind ocamlopt -o curl.bin curl.ml -package uri,lwt.unix,cohttp.lwt -linkpkg -pp 'sed "s/^#.*;;//"'

file curl.bin
./curl.bin http://httpbin.org/status/418

(* Simple Makefile *)

all:cur.byte curl.bin

curl.byte:
    ocamlfind ocamlc -o curl.byte curl.ml -package uri,lwt,lwt.unix,cohttp.lwt -linkpkg -pp 'sed "s/^#.*;;//"'

curl.bin:ocamlfind ocamlopt -o curl.bin curl.ml -package uri,lwt,lwt.unix,cohttp.lwt -linkpkg -pp 'sed "s/^#.*//"'

test: test.byte test.bin

test.byte: 
    @echo "Testing curl.byte"
    ./curl.byte http://httpbin.org/status/418

clean:
    rm -rf *.cmo *.cmi *.o *.cmx *.bin *.byte


(* Building and Testing *)
make test
Testing curl.byte
./curl.byte http://httpbin.org/status/418

Testing curl.bin
./curl.byte http://httpbin.org/status/418

make clean
rm -rf *.cmo *.cmi *.o *.cmx *.bin *.byte



(* Compiling a single File and a single Module *)

(* Compiling to bytecode *)

ocamlfind ocamlc -c tools.ml -package unix -linkpkg
file tools.cmi
file.cmo

(* Loading in the Toplevel *)

#load "tools.cmo";;
#use "topfind";;
#require "package";;
#list;;
#camlp4o;;
#camlp4r;;
#predicates "p,q,...";;
Topfind.reset();;
#thread;;
 (** All modules dependencies must be loaded 
        before it is loaded in the REPL 

        Instead of #load "unix.cma" it could be #require "unix" ;;
    *)
#load "unix.cma";;
#load "tools.cmo";;
#show Tools;;
#Tools.execute_in_dir;;
#Sys.getcwd ();;
#Tools.execute_in_dir "/etc/boot" "ls";;
#Sys.getcwd ();;


ocamlfind ocamlc -o main.byte tools.ml main.ml  -package unix -linkpkg -verbose
Effective set of compiler predicates: pkg_unix,autolink,byte
+ ocamlc.opt -o main.byte -verbose /home/tux/.opam/4.02.1/lib/ocaml/unix.cma tools.ml main.ml

file main.byte

./main.byte /boot

ocamlfind ocamlopt -o main.bin tools.ml main.ml  -package unix -linkpkg -verbose
Effective set of compiler predicates: pkg_unix,autolink,native
+ ocamlopt.opt -o main.bin -verbose /home/tux/.opam/4.02.1/lib/ocaml/unix.cmxa tools.ml main.ml
+ as -o 'tools.o' '/tmp/camlasm78e933.s'
+ as -o 'main.o' '/tmp/camlasmb3767b.s'
+ as -o '/tmp/camlstartup24f721.o' '/tmp/camlstartup77e48a.s'
+ gcc -o 'main.bin'   '-L/home/tux/.opam/4.02.1/lib/ocaml'  '/tmp/camlstartup24f721.o' '/home/tux/.opam/4.02.1/lib/ocaml/std_exit.o' 'main.o' 'tools.o' '/home/tux/.opam/4.02.1/lib/ocaml/unix.a' '/home/tux/.opam/4.02.1/lib/ocaml/stdlib.a' '-lunix' '/home/tux/.opam/4.02.1/lib/ocaml/libasmrun.a' -lm  -ldl

du -h main.bin

file main.bin

./main.bin /boot

(* Simple Makefile *)

main.byte:
    ocamlfind ocamlc -o main.byte tools.ml main.ml -package unix -linkpkg -verbose

main.bin:
    ocamlfind ocamlopt -o main.bin tools.ml main.ml -package unix -linkpkg -verbose

clean:
    rm -rf *.cmo *.cmi *.cmx *.bin *.byte

