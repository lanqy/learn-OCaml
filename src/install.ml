(* 加载库 *)
#use "topfind";;


(* 列出已安装的包utops *)
#list;;

(* 加载已安装的OCaml包 *)
#require "batteries"

(* 加载ML文件，源代码 *)
#use "text.ml";;

(* 将ML文件加载为模块 *)
#mod_use "text.ml";;

(* 显示模块签名 （Ocaml版本> = 4.2） *)
#show Filename;;

(* 浏览器OCaml类型签名。 *)
ocamlfind browser -all
ocamlfind ocamlbrowser -package core
ocamlfind browser -package batterie

(* 查找Ocaml和Opam的版本 *)
ocaml -version

opam --version

ocamlc -v

ocamlopt -v

utop -version


(* 获取有关编译文件的信息 *)
ocamlobjinfo seq.cmo

ocamlobjinfo seq.cma

ocamlobjinfo seq.cmi



(* opam 版本 *)
opam --version

(* 列出OCaml编译器的已安装版本 *)
opam switch list

(* 切换到ocaml版本4.02.1： *)
opam switch 4.02.1

(* 搜索包 *)
opam search core

(* 安装包 *)
opam install packagename 

(* 升级包 *)
opam upgrade

(* 显示所有已安装的软件包 *)
ocamlfind list