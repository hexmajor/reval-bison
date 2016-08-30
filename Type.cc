/**
 *
 * Type.cc
 *
 */

#include "Reval.hh"

namespace Reval {

Type::Type(int i) {
  ival_ = i;
  is_int_ = true;
  is_float_ = is_string_ = false;
}

Type::Type(float f) {
  fval_ = f;
  is_float_ = true;
  is_int_ = is_string_ = false;
}

Type::Type(std::string s) {
  sval_ = s;
  is_string_ = true;
  is_int_ = is_float_ = false;
}

}
