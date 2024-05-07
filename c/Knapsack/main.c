#include "knapsack.h"
#include <stdio.h>
#include <stdlib.h>

int main() {
  item_t items[] = {
      {.weight = 2, .value = 2},  {.weight = 2, .value = 2},
      {.weight = 2, .value = 2},  {.weight = 2, .value = 2},
      {.weight = 10, .value = 5},
  };

  size_t item_count = sizeof(items) / sizeof(items[0]);

  unsigned int maximum_weight = 10;

  printf("%zu\n", maximum_value(maximum_weight, items, item_count));
  return EXIT_SUCCESS;
}
