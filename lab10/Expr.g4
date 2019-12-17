grammar Expr;

// ***Lexing rules***

INT     : [0-9]+ ;
NEWLINE : '\r'? '\n' ;
WS      : [ \t]+ -> skip ; // ignore whitespace
ID      : [a-zA-Z]+; //alphabet chars

MUL : '*' ;
DIV : '/' ;
ADD : '+' ;
SUB : '-' ;


// ***Parsing rules ***

/** The start rule */
prog: stat+ ;

stat: expr NEWLINE              # printExpr
    | NEWLINE                   # blank
    | ID '=' expr //Assigning 
    ;

expr: expr op=( '*' | '/' ) expr   # MulDiv
    | expr op=( '+' | '-' ) expr   # AddSub
    | INT                       # int
    | '(' expr ')'              # parens
        | ID //ID
    ;

