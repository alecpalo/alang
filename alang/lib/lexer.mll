(* lexer.mll *)
{
    open Parser
    let next_line lexbuf =
        let pos = lexbuf.Lexing.lex_curr_p in
        lexbuf.Lexing.lex_curr_p <- { pos with
            Lexing.pos_lnum = pos.Lexing.pos_lnum + 1;
            Lexing.pos_bol = pos.Lexing.pos_cnum;
        }
    exception Error of string
}

let digit = ['0'-'9']
let letter = ['a'-'z' 'A'-'Z']
let identifier = letter (letter | digit | '_')*
let whitespace = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"

rule token = parse
  | whitespace { token lexbuf }
  | newline { next_line lexbuf; token lexbuf}
  | digit+ as int_lit { INT(int_of_string int_lit) }
  | '+' { PLUS }
  | '-' { MINUS }
  | '*' { TIMES }
  | '/' { DIVIDE }
  | '(' { LPAREN }
  | ')' { RPAREN }
  | identifier as id { VAR(id) }
  | eof { EOF }
  | _ as char { raise (Error (Printf.sprintf "Unexpected character: '%c'" char)) }