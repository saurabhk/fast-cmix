#ifndef CONTEXT_H
#define CONTEXT_H

class Context {
 public:
  virtual ~Context() {}
  bool IsEqual(Context* c) { return false; }
  const unsigned long long& GetContext() const { return context_; }
  unsigned long long Size() const { return size_; }

 protected:
  void Update() {}
  unsigned long long context_, size_;
};

#endif

