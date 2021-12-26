type package = None | Gift | Box of package list ;;
exception E ;;
let stack : package list = [] ;;
let table : package = None;;

let g (t, st) = match t with
  | None -> (Gift, st) 
  | t -> (Gift, t :: st);;

let b (t, st) = match t with
  | None -> (Box[], st) 
  | t -> (Box[], t :: st);;

let p (t, st) = match t, st with
  | _, [] | None, _ | Gift, _ -> raise E
  | Box[], top :: tail -> (Box[top], tail)
  | Box(el :: en), top :: tail -> (Box([top;el] @ en), tail)
;;


let str = "gbpbpbbbpbpppbp" ;;

let chars = List.of_seq (String.to_seq str) ;;

let rec iterate (cs, (t, st)) = match cs with
  | [] -> (t, st)
  | 'g' :: tail -> iterate (tail,g(t, st))
  | 'b' :: tail -> iterate (tail,b(t, st))
  | 'p' :: tail -> iterate (tail,p(t, st))
  | _ :: _ -> raise E
;;

let fin = iterate (chars, (table, stack)) ;;

let rec list_to_string = function
  | [] -> ""
  | [Gift] -> "Gift"
  | Gift :: tail -> "Gift;" ^ list_to_string tail
  | [Box(l)] -> "Box[" ^ list_to_string l ^ "]"
  | Box(l) :: tail -> "Box[" ^ list_to_string l ^ "];" ^ list_to_string tail
  | _ -> raise E
;;

let package_to_string = function
  | Box(a::b) -> "Box[" ^ (list_to_string (a::b)) ^ "]"
  | _ -> raise E
;;

let print_package_tuple (t, st) = match t, st with
  | _ , _ :: _ -> print_string "fail"
  | t , [] -> print_string (package_to_string (t))
;;

print_package_tuple fin ;;