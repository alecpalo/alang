(* bin/main.ml *)
open Alang

let rec read_and_accumulate accum = 
  try 
    let line = input_line stdin in 
    read_and_accumulate (accum ^ "\n" ^ line)
  with 
    End_of_file -> accum

let () =
  let input = read_and_accumulate "" in
  let lexbuf = Lexing.from_string input in
  try
    let program = Parser.program Lexer.token lexbuf in  (* Now program is of type Ast.program = Ast.expr list *)
    List.iter (fun expr -> print_endline (Ast.string_of_expr expr)) program  (* Iterate over the list and print each expr *)
  with
  | Parser.Error -> prerr_endline "Parser error"
  | Lexer.Error msg -> prerr_endline ("Lexer error: " ^ msg)
