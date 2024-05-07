#include "armstrong_numbers.h"
#include <stdio.h>

int ipow(int base, int exp);
unsigned int log10c(unsigned int num);

int ipow(int base, int exp) {
  int result = 1;
  for (;;) {
    if (exp & 1)
      result *= base;
    exp >>= 1;
    if (!exp)
      break;
    base *= base;
  }

  return result;
}

// ceil(log10(n))
unsigned int log10c(unsigned int num) {
  unsigned int n = 0;
  for (; num; num /= 10) {
    n++;
  }
  return n;
}

bool is_armstrong_number(int candidate) {
  unsigned int exp = log10c(candidate);
  int result = 0;
  for (int rem = candidate; rem; rem /= 10) {
    result += ipow(rem % 10, exp);
  }
  return candidate == result;
}

int main() { printf("%i", is_armstrong_number(153)); }
