(* parser.mly *)
%{
open Ast
%}

%token <int> INT
%token <string> VAR
%token PLUS MINUS TIMES DIVIDE LPAREN RPAREN EOF
%left PLUS MINUS
%left TIMES DIVIDE
%start <Ast.program> program
%type <Ast.expr> expr
%%

program:
| expr_list EOF { $1 }

expr_list:
| expr { [$1] }
| expr_list expr { $1 @ [$2] }

expr:
| INT { Int($1) }
| VAR { Var($1) }
| expr PLUS expr { BinOp($1, Add, $3) }
| expr MINUS expr { BinOp($1, Sub, $3) }
| expr TIMES expr { BinOp($1, Mul, $3) }
| expr DIVIDE expr { BinOp($1, Div, $3) }
| LPAREN expr RPAREN { $2 }
