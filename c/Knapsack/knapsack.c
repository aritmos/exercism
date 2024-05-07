#include "knapsack.h"
#include <stdint.h>
#include <stdlib.h>

#define max(x, y) ((x) > (y)) ? (x) : (y)

size_t maximum_value(unsigned int maximum_weight, item_t *items,
                     size_t item_count) {
  uint32_t(*table)[item_count + 1][maximum_weight + 1] = malloc(sizeof(*table));

  memset(table, 0, maximum_weight + 1);
  for (uint32_t i = 1; i <= item_count; i++) {
    for (uint32_t j = 0; j <= maximum_weight; j++) {
      uint32_t v = items[i - 1].value;
      uint32_t w = items[i - 1].weight;

      (*table)[i][j] =
          (w > j) ? (*table)[i - 1][j]
                  : max((*table)[i - 1][j], (*table)[i - 1][j - w] + v);
    }
  }

  uint32_t ans = (*table)[item_count][maximum_weight];
  free(table);
  return ans;
}
