#include "nucleotide_count.h"
#include <stdio.h>
#include <stdlib.h>

int main(void) {
  {
    char *ans = nucleotide_count("");
    printf("%s\n", ans);
    free(ans);
  }
  {
    char *ans = nucleotide_count("G");
    printf("%s\n", ans);
    free(ans);
  }
  {
    char *ans = nucleotide_count("GGGGGGG");
    printf("%s\n", ans);
    free(ans);
  }
  {
    char *ans = nucleotide_count("AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGAT"
                                 "TAAAAAAAGAGTGTCTGATAGCAGC");
    printf("%s\n", ans);
    free(ans);
  }
  {
    char *ans = nucleotide_count("AGXXACT");
    printf("%s\n", ans);
    free(ans);
  }
  return 0;
}
