/**
 *
 * main.cc - Reval Framework Usage Example
 *
 */

#include "Reval.hh"
#include <cstdlib>

int main(int argc, char **argv) {

  auto builder = new Reval::ExpressionBuilder(argv[1]);
  auto expr = builder->build();

  auto context = new Reval::ExpressionContext();
  auto result = expr->reval(*context);

  //std::cout << "Expression result is NULL for now." << std::endl;
  return 0;
}
