/**
 *
 *
 * Reval.hh
 *
 */

#ifndef _REVAL_HH_
#define _REVAL_HH_

#include <string>
#include <list>
#include <queue>

#include "ExpressionParser.tab.hh"

namespace Reval {

class Expression;
class ExpressionParserContext;

class Type {
public:
  Type(int i);
  Type(float f);
  Type(std::string s);

  bool isInt() { return is_int_; }
  bool isFloat() { return is_float_; }
  bool isString() { return is_string_; }

  int ival_;
  float fval_;
  std::string sval_;

private:
  bool is_int_, is_float_, is_string_;

};

/* Reval expressions are evaluated within a context. */
class ExpressionContext {
public:
  ExpressionContext();
  ~ExpressionContext();

  Type* invokeMethod(const std::string method_name, const std::list<Expression> params, const ExpressionContext& context);
  Type* getIdentifierValue(const std::string identifier);

};

/* A re-evaluatable expression */
class Expression {
public:
  Expression();
  ~Expression();

  void pushOperand(Type* operand);
  void pushOp(std::string op);

  Type* reval();
  Type* reval(const ExpressionContext& context);

private:
  std::queue<Type> operand_queue_;
  std::queue<std::string> op_queue_;

};

/* Build a reval expression from a string */
class ExpressionBuilder {
public:
  ExpressionBuilder(const std::string expr);
  ~ExpressionBuilder();

  Expression* build();

private:
  std::string expr_;
  ExpressionParserContext* parser_context_;

};

class ExpressionParserContext {
public:
  ExpressionParserContext();
  virtual ~ExpressionParserContext();

  /* Parser */
  int parse(std::string str);

  /* Called on Parser Error */
  //void error (const yy::location& location, const std::string& message);
  void error (const yy::location& loc, const std::string& msg);
  void error (const std::string& message);

  Expression* expression_;

private:
  /* Scanner */
  void initScanner();
  void destroyScanner();

  std::string expr_;

};

}

#define YY_DECL yy::ExpressionParser::symbol_type yylex (Reval::ExpressionParserContext& context)
YY_DECL;

#endif
