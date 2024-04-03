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
let int = '-'? digit+
let letter = ['a'-'z' 'A'-'Z']
let identifier = letter (letter | digit | '_')*
let whitespace = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"
let singleLineComment = "//"
let multiLineCommentStart = "/*"
let mutliLineCommentEnd = "*/"

rule token = 
    parse
    | whitespace { token lexbuf }
    | newline { next_line lexbuf; token lexbuf}
    | digit+ as int_lit { INT(int_of_string int_lit) }
    | singleLineComment { read_single_line_comment lexbuf }
    | multiLineCommentStart { read_multi_line_comment lexbuf }
    | '+' { PLUS }
    | '-' { MINUS }
    | '*' { TIMES }
    | '/' { DIVIDE }
    | '(' { LPAREN }
    | ')' { RPAREN }
    | identifier as id { VAR(id) }
    | eof { EOF }
    | _ as char { raise (Error (Printf.sprintf "Unexpected character: '%c'" char)) }

    and read_single_line_comment = parse
    | newline { next_line lexbuf; token lexbuf} 
    | eof { EOF }
    | _ { read_single_line_comment lexbuf }

    and read_multi_line_comment = parse
    | "*/" { token lexbuf }
    | newline { next_line lexbuf; read_multi_line_comment lexbuf }
    | eof { raise (Error ("Lexer - Unexpected EOF - please terminate your comment.")) }
    | _ { read_multi_line_comment lexbuf }