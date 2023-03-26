#ifndef PAQ8HP_H
#define PAQ8HP_H

#include "model.h"
#include <vector>
#include <memory>

namespace paq8hp {
  class Predictor;
}

class PAQ8HP : public Model {
 public:
  PAQ8HP(int memory);
  const std::valarray<float>& Predict() const;
  unsigned int NumOutputs();
  void Perceive(int bit);
  void ByteUpdate() {};

 private:
  std::unique_ptr<paq8hp::Predictor> predictor_;
};
#include "paq8hp.hpp"

#endif

