/**
 *
 * ExpressionParserContext.cc
 *
 */

#include "Reval.hh"

namespace Reval {

ExpressionParserContext::ExpressionParserContext() {
  this->expression_ = new Expression();
}

ExpressionParserContext::~ExpressionParserContext() {

}

int ExpressionParserContext::parse(std::string str) {
    this->expr_ = str;
    initScanner();
    yy::ExpressionParser parser(*this);
    //parser.set_debug_level(1);
    //parser.set_debug_stream(std::cout);
    int result = parser.parse();
    if (result != 0) {
      std::cout << "reval error: " << "terminal error" << std::endl;
    }
    destroyScanner();
    return result;
}

void ExpressionParserContext::error(const yy::location& location, const std::string& message) {
  std::cout << "reval error: " << message << std::endl;
}

void ExpressionParserContext::error(const std::string& message) {
  std::cout << "reval error: " << message << std::endl;
}

}
