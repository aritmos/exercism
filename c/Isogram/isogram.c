#include "isogram.h"
#include <stddef.h>

bool is_isogram(const char *phrase) {
  if (phrase == NULL) {
    return false;
  }
  int letters[26] = {0};
  for (; *phrase != '\0'; phrase++) {
    char c = *phrase;
    if ('A' <= c && c <= 'Z') {
      c += 'a' - 'A'; // make `c` lowercase
    }
    if ('a' <= c && c <= 'z') {
      if (letters[c - 'a']++) {
        return false;
      }
    }
  }
  return true;
}
