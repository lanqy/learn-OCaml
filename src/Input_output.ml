print_string "Hello world!\n";;

print_int 100;;

print_float 23.23;;

print_char 'c';;

let s = Printf.sprintf "x = %s y = %f z = %d" "hello" 2.2223 40;;

print_string s;;

Printf.printf "%d" 100;;
Printf.printf "%s %d %f" "This is" 100 2.232;;
Printf.printf "x = %s y = %f z = %d" "hello" 2.2232 40;;