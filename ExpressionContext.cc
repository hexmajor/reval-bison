/**
 *
 * ExpressionContext.cc
 *
 */

#include "Reval.hh"

namespace Reval {

ExpressionContext::ExpressionContext() {

}

ExpressionContext::~ExpressionContext() {

}

Type* invokeMethod(const std::string method_name, const std::list<Expression> params, const ExpressionContext& context) {
  return new Type(0);
}

Type* getIdentifierValue(const std::string identifier) {
  return new Type(0);
}

}
