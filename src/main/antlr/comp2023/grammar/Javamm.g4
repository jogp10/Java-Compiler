grammar Javamm;

@header {
    package pt.up.fe.comp2023;
}

INTEGER : [0-9]+ ;
ID : [$a-zA-Z_][$a-zA-Z_0-9]* ;

LOGICAL_OP : '&&' | '||' ;
COMP_OP : '==' | '!=' | '<' | '>' | '<=' | '>=';

MULTDIV : '*' | '/';
PLUSMINUS : '+' | '-';
PAR_OPEN : '(';
PAR_CLOSE : ')';


WS : [ \t\n\r\f]+ -> skip ;
COMMENT : '/*' (COMMENT|.)*? '*/' -> skip ;
LINE_COMMENT  : '//' .*? '\n' -> skip ;

program
    : (importDeclaration)* classDeclaration EOF
    ;

importDeclaration
    : 'import' library+=ID ('.' library+=ID)* ';';

classDeclaration
    : 'class' name=ID ('extends' extend=ID)? '{' (varDeclaration)* (methodDeclaration)* '}'
    ;

varDeclaration
    : type var=ID ';'
    | type var=ID '=' expression ';'
    ;

parameter
    : type var=ID
    ;

mainParam
    : type_='String' '['']' var=ID
    ;

methodDeclaration
    : ('public')? type name=ID '(' (parameter (',' parameter)*)? ')' '{' (varDeclaration)* (statement)* 'return' expression ';' '}' #Method
    | ('public')? 'static' 'void' name='main' '(' mainParam ')' '{' (varDeclaration)* (statement)* '}' #MainMethod
    ;

type locals[boolean isArray=false]
    : type_='int'('['']' {$isArray=true;})? #IntType
    | type_='boolean' #BooleanType
    | type_='void' #VoidType
    | type_=ID #ObjectType
    | type_='String' ('['']' {$isArray=true;}) #StringType
    ;

statement
    : '{' (statement)* '}' #Block
    | 'if' '(' expression ')' statement 'else' statement #IfElse
    | 'while' '(' expression ')' statement #While
    | expression ';' #Stmt
    | id=ID '=' expression ';' #Assign
    | id=ID '[' expression ']' '=' expression ';' #ArrayAssign
    ;

expression
    : PAR_OPEN expression PAR_CLOSE #Parenthesis
    | value=('true' | 'false') #Boolean
    | '!'expression #UnaryOp
    | expression op=MULTDIV expression #BinaryOp
    | expression op=PLUSMINUS expression #BinaryOp
    | expression op=COMP_OP expression #BinaryOp
    | expression op=LOGICAL_OP expression #BinaryOp
    | value=INTEGER #Integer
    | id=ID #Identifier
    | expression '[' index=expression ']' #ArrayAccess
    | expression '.' 'length' #ArrayLength
    | expression '.' method=ID '(' ( expression (',' expression)* )? ')' #MethodCall
    | 'new' 'int' '[' size=expression ']' #NewIntArray
    | 'new' id=ID '(' ')' #NewObject
    | 'this' #This
    ;
