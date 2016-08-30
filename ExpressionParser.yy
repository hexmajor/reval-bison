/**
 *
 * ExpressionParser.yy
 *
 */

%skeleton "lalr1.cc"
%require "3.0.4"

%defines
%define parser_class_name {ExpressionParser}
%define api.token.constructor
%define api.token.prefix {TOKEN_}
%define api.value.type variant
%define parse.trace
%define parse.error verbose

%code requires {
  #include "string.h"
  #include <cstdio>
  namespace Reval {
    class ExpressionParserContext;
  }
}

/* Parser/scanner context */
%param {
  Reval::ExpressionParserContext& context
}

%locations

%code {
  #include "Reval.hh"
}

%initial-action {
    /*@$.begin.filename = @$.end.filename = &context.file; */
}

%token
  END 0 "end"
  LPAREN "("
  RPAREN ")"
  LBRACE "{"
  RBRACE "}"
  ASSIGN ":"
  SEMI ";"
  COMMA ","
  MINUS "-"
  PLUS "+"
  STAR "*"
  SLASH "/"
;

%token <std::string>  IDENTIFIER   "identifier"
%token <std::string>  LITERAL      "literal"
%token <int>          NUMBER       "number"
%token <float>        FLOAT        "float"

%%

%start unit;

unit: expression "end";

%left "+" "-";
%left "*" "/";
expression:
  "(" expression ")"
| expression "+" expression       { printf("+ "); context.expression_->pushOp("+"); }
| expression "-" expression       { printf("- "); context.expression_->pushOp("-"); }
| expression "*" expression       { printf("* "); context.expression_->pushOp("*"); }
| expression "/" expression       { printf("/ "); context.expression_->pushOp("/"); }
| "identifier"                    { printf("get<%s> ", $1.c_str()); context.expression_->pushOperand(new Reval::Type($1.c_str())); }
| "number"                        { printf("%d ", $1); context.expression_->pushOperand(new Reval::Type($1)); }
| "float"                         { printf("%f ", $1); context.expression_->pushOperand(new Reval::Type($1)); };

/*  "identifier" "(" params ")"     {  printf("%s ", $1.c_str()); } */

/*
params:
  expression
| expression "," params;
*/

%%

void yy::ExpressionParser::error(const location_type& loc, const std::string& message) {
  context.error(loc, message);
}
