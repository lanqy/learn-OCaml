let file = open_out "/tmp/file.txt";;

output_string file "hello\n";;

output_string file "world\n";;

close_out file;;


let filein = open_in "/tmp/file.txt";;

input_line filein;;

input_line filein;;

input_line filein;;

input_char;;

input_char filein;;