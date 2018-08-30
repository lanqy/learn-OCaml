(* 获取当前的工作目录 *)
Unix.getcwd ();;

(* 更改当前工作目录 *)
Unix.chdir "/";;

(* 获取环境变量 *)
Unix.getenv "PATH";;

(* 设置环境变量 *)
Unix.putenv "DUMMYVAR" "Test value";;

Unix.getenv "DUMMYVAR";;

Unix.environment ();;

Unix.gethostname ();;

(* 获取当前进程ID，PID *)

Unix.getpid ();;

(* 读输入通道 *)
let read_channel ch =
  let b = Buffer.create 0 in

  let reader chn =
    try Some (input_line chn)
    with End_of_file -> None
  
  in let rec aux () =
    match reader ch with
    | None -> ()
    | Some line -> Buffer.add_string b (line ^ "\n"); aux ()
  in aux ();
  Buffer.contents b;;

open_in ;;

let fd = open_in "/tmp/data.txt";;

read_channel fd |> print_string;;

Unix.open_process_in;;

let fd = Unix.open_process_in "ls";;

read_channel fd |> print_string;;

let popen_in cmd =
  let fd = Unix.open_process_in cmd in
  read_channel fd;;

popen_in "uname -r";;