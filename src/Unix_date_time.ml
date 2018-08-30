let today_date () =
  let open Unix in
  let tm = time () |> gmtime in
  (tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);;

let make_date (y, m, d) =
  let open Unix in
  {
    tm_sec = 0;
    tm_min = 0;
    tm_hour = 0;
    tm_mday = d;
    tm_mon = m - 1;
    tm_year = y - 1900;
    tm_yday = 0;
    tm_wday = 0;
    tm_isdst = false;
  };;

let print_dtime tm = 
  let open Unix in
  Printf.printf "Year %d\n" (tm.tm_year + 1900);
  Printf.printf "Month %d\n" (tm.tm_mon + 1);
  Printf.printf "Day %d\n" tm.tm_mday;
  Printf.printf "Hour %d\n" tm.tm_hour;
  Printf.printf "Min %d\n" tm.tm_min;
  Printf.printf "Sec %d\n" tm.tm_sec;;


make_date (2018, 8, 30) |> print_dtime;;

let tzone () =
    let open Unix in
    let epc1 = time () in
    let epc2, _ = epc1 |> gmtime |> mktime in
    int_of_float @@ (epc2 -. epc1) /. 3600.;;

let test_time_zone epoch =
  let tm1 =
      epoch +. (float_of_int (tzone ())) *. 3600.0
      |> Unix.localtime in
  let tm2 = Unix.gmtime epoch in
  tm1 = tm2;;

let t1 = Unix.time ();;
let t2 = Unix.time ();;
let t3 = Unix.time ();;

List.map test_time_zone [t1;t2;t3];;

let ec = Unix.time ();;

let tm = ec |> Unix.localtime ;;

Unix.mktime;;

let (epoch, tm2) = Unix.mktime tm;;

epoch = ec;;

tm2 = tm;;

let dtime_to_epoch tm = 
  let (ep, _) = Unix.mktime tm in
  ep;;

let day_count dtm1 dtm2 =
  let seconds = (dtime_to_epoch dtm2) -. (dtime_to_epoch dtm1) in
  (int_of_float (seconds /. 86400.)) + 1;;
  


