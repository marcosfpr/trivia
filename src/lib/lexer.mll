{
  module L = Lexing

  type token = [%import: Parser.token] [@@deriving show]

  let illegal_character loc char =
    Error.error loc "illegal character '%c'" char

  let of_string = function
    | "true" -> true
    | "false" -> false
    | _ -> raise (Invalid_argument "Invalid literal boolean.")

}

let spaces = [' ' '\t']+
let digit = ['0'-'9']
let integer = digit+

let boolean = "true" | "false"
let validId = ['a'-'z' 'A'-'Z'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule token = parse
  | spaces            { token lexbuf }
  | '\n'              { L.new_line lexbuf; token lexbuf }
  | integer as lxm    { LITINT (int_of_string lxm) }
  | "int"             { INT }
  | boolean as lxm    { LITBOOL (of_string lxm) }
  | "bool"            { BOOL }
  | '('               { LPAREN }
  | ')'               { RPAREN }
  | "let"             { LET }
  | "in"              { IN } 
  | "if"              { IF }
  | "then"            { THEN }
  | "else"            { ELSE }
  | '+'               { PLUS }
  | '<'               { LT }
  | '='               { EQ }
  | ','               { COMMA }
  (* Achei que deveria ser utilizado símbolos para identificar : Symbol.new_symbol *)
  | validId as lxm    { ID  (lxm) } 
  | eof               { EOF }
  | _                 { illegal_character (Location.curr_loc lexbuf) (L.lexeme_char lexbuf 0) }
