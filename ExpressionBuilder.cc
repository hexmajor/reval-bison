/**
 *
 * ExpressionBuilder.cc
 *
 */

#include <string>

#include "Reval.hh"

namespace Reval {

ExpressionBuilder::ExpressionBuilder(std::string expr) {
  this->expr_ = expr;
  this->parser_context_ = new ExpressionParserContext();
}

ExpressionBuilder::~ExpressionBuilder() {

}

Expression* ExpressionBuilder::build() {
  this->parser_context_->parse(this->expr_);
  return new Expression();
}

}
