#include "testfun.hpp"
#include <stdio.h>
#include "libcall.hpp"

int main(int argc, char * argv[])
{
  printf("hello world!\n");
  foo(3);
  libcall();
  return 0;
}
