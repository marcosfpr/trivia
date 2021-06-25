// parser.mly

%token                 EOF
%token <int>           LITINT
%token <bool>          LITBOOL
%token                 INT
%token                 BOOL
%token                 LPAREN
%token                 RPAREN
%token                 LET
%token                 IN
%token                 IF
%token                 THEN
%token                 ELSE
%token <string>        ID // achei que deveria ser <string * int>
%token                 EQ
%token                 LT
%token                 COMMA
%token                 PLUS
%%
