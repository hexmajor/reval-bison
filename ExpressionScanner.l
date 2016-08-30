/**
 *
 * Expression.l - Reval Expression Scanner Generator Input
 *
 */

%{

#include "stdio.h"
#include "string.h"
#include "ExpressionParser.tab.hh"
#include "Reval.hh"

#define yyterminate() return yy::ExpressionParser::make_END(loc);

static yy::location loc;

%}

%option outfile="ExpressionScanner.c"
%option noyywrap nounput batch noinput debug

LPAREN "("
RPAREN ")"
LBRACE "{"
RBRACE "}"
ASSIGN ":"
COMMA  ","
MINUS "-"
PLUS "+"
STAR "*"
SLASH "/"

WHITESPACE [ \r\t\n]+
NEWLINE [\n]

DIGIT  [0-9]
LETTER [a-zA-Z]
HEXDIGIT [0-9a-fA-F]

NUMBER {DIGIT}+
FLOAT   {DIGIT}+"."{DIGIT}+
LITERAL "\"".+"\""

IDENTIFIER [a-zA-Z_][a-zA-Z0-9]*

%{
#define YY_USER_ACTION loc.columns (yyleng);
%}

%%

%{
loc.step();
%}

{LBRACE}        { return yy::ExpressionParser::make_LBRACE(loc); }
{RBRACE}        { return yy::ExpressionParser::make_RBRACE(loc); }
{LPAREN}        { return yy::ExpressionParser::make_LPAREN(loc); }
{RPAREN}        { return yy::ExpressionParser::make_RPAREN(loc); }
{ASSIGN}        { return yy::ExpressionParser::make_ASSIGN(loc); }
{COMMA}         { return yy::ExpressionParser::make_COMMA(loc); }
{MINUS}         { return yy::ExpressionParser::make_MINUS(loc); }
{PLUS}          { return yy::ExpressionParser::make_PLUS(loc); }
{STAR}          { return yy::ExpressionParser::make_STAR(loc); }
{SLASH}         { return yy::ExpressionParser::make_SLASH(loc); }

{NUMBER}        { return yy::ExpressionParser::make_NUMBER(atoi(yytext), loc); }
{FLOAT}         { return yy::ExpressionParser::make_FLOAT(atof(yytext), loc); }
{LITERAL}       { return yy::ExpressionParser::make_LITERAL(strdup(yytext), loc); }

{IDENTIFIER}    { return yy::ExpressionParser::make_IDENTIFIER(strdup(yytext), loc); }
{NEWLINE}+      { loc.lines(yyleng); loc.step(); }
{WHITESPACE}+   { loc.step(); }

%%

namespace Reval {

void ExpressionParserContext::initScanner()
{
  printf("Initializing scanner with expression: %s\n", expr_.c_str());
  yy_flex_debug = 0;
	//YY_BUFFER_STATE bs = yy_scan_buffer(strdup(expr_.c_str()), sizeof(expr_.c_str()));
  YY_BUFFER_STATE bs = yy_scan_string(strdup(expr_.c_str()));
	yy_switch_to_buffer(bs);
}

void ExpressionParserContext::destroyScanner()
{
  //
  //fclose (yyin);
}

}
