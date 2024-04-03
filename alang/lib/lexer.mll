{
  open Parser
}

(* Dfine helper regexes *)
let digit = ['0'-'9']
let alpha = ['a'-'z' 'A'-'Z']
let frac = '.' digit*
let ex = ['e' 'E'] ['-' '+']? digit+
let float = digit* frac? exp?
let int = '-'? digit+
let id = (alpha) (alpha|digit|'_')*
let whitespace = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"

rule read_token =
  parse
  | whitespace { read lexbuf }
  | newline {next_line lexbuf; read lexbuf}
  | int {INT (int_of_string (Lexing.lexeme lexbuf))}
  | float    { FLOAT (float_of_string (Lexing.lexeme lexbuf)) }
  | "true"   { TRUE }
  | "false"  { FALSE }
  | "null"   { NULL }
  | '"'      { read_string (Buffer.create 17) lexbuf }
  | '{'      { LEFT_BRACE }
  | '}'      { RIGHT_BRACE }
  | '['      { LEFT_BRACK }
  | ']'      { RIGHT_BRACK }
  | ':'      { COLON }
  | ','      { COMMA }
  | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
  | eof      { EOF }

