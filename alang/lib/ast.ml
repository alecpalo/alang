(* ast.ml *)
type operator = Add | Sub | Mul | Div

type expr =
  | Int of int                  (* Integer literals *)
  | Var of string               (* Variables *)
  | BinOp of expr * operator * expr  (* Binary operations *)

type program = expr list  (* Corrected to explicitly be a list of expr *)

let rec string_of_expr = function
  | Int n -> string_of_int n
  | Var v -> v
  | BinOp (e1, op, e2) ->
    "(" ^ string_of_expr e1 ^ " " ^ string_of_op op ^ " " ^ string_of_expr e2 ^ ")"

and string_of_op = function
  | Add -> "+"
  | Sub -> "-"
  | Mul -> "*"
  | Div -> "/"
