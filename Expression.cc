/**
 *
 * Expression.cc
 *
 */

#include "Reval.hh"

namespace Reval {

Expression::Expression() {

}

Expression::~Expression() {

}

void Expression::pushOperand(Type* operand) {
  operand_queue_.push(*operand);
}

void Expression::pushOp(std::string op) {
  op_queue_.push(op);
}

Type* Expression::reval() {
  //std::cout << "Operand queue size: " << operand_queue_.size() << std::endl;
  //std::cout << "Op queue size: " << op_queue_.size() << std::endl;
  return new Type(0);
}

Type* Expression::reval(const ExpressionContext& context) {
  //std::cout << "Operand queue size: " << operand_queue_.size() << std::endl;
  //std::cout << "Op queue size: " << op_queue_.size() << std::endl;
  return new Type(0);
}

}
