#include "nucleotide_count.h"
#include <memory.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

typedef uint8_t u8;
typedef uint32_t u32;

/// Returns the length in digits of the given integer.
u8 u32_len(u32 n);

/// writes a u32 into a buffer as a string
///
/// SAFETY: buffer must contain enough capacity to write the integer.
void write_u32(char *buf, u32 n, u8 len);

void write_nucleotide(char *buf, char nucleotide, u32 cnt, u8 cnt_len);

typedef struct nucleotide_info {
  u32 a_cnt;
  u32 c_cnt;
  u32 g_cnt;
  u32 t_cnt;

  u8 a_len;
  u8 c_len;
  u8 g_len;
  u8 t_len;
} neuclotide_info;

u32 total_len(neuclotide_info info);

u32 total_len(neuclotide_info info) {
  return info.a_len + info.c_len + info.g_len + info.t_len;
}

char *format_counts(neuclotide_info info);

char *nucleotide_count(const char *dna_strand) {
  u32 a_cnt = 0;
  u32 c_cnt = 0;
  u32 g_cnt = 0;
  u32 t_cnt = 0;

  char *empty_str;
  for (u32 i = 0; dna_strand[i] != 0; i++) {
    switch (dna_strand[i]) {
    case 'A':
      a_cnt++;
      break;
    case 'C':
      c_cnt++;
      break;
    case 'G':
      g_cnt++;
      break;
    case 'T':
      t_cnt++;
      break;
    default:
      empty_str = (char *)calloc(1, 1);
      return empty_str;
    }
  }

  // return the formatted counts

  neuclotide_info info = {
      a_cnt,          c_cnt,          g_cnt,          t_cnt,
      u32_len(a_cnt), u32_len(c_cnt), u32_len(g_cnt), u32_len(t_cnt),
  };

  return format_counts(info);
}

const char HEADER[] = "_:";
const size_t HEADER_LEN = 2;
const char SEPARATOR = ' ';
const size_t SEPARATOR_LEN = 1;

char *format_counts(neuclotide_info info) {

  u32 count_len = total_len(info);
  u32 total_len = (u32)(HEADER_LEN + SEPARATOR_LEN) * 4 + count_len;
  char *buf = (char *)malloc(sizeof(char) * total_len);

  size_t idx = 0;
  write_nucleotide(buf + idx, 'A', info.a_cnt, info.a_len);
  idx += HEADER_LEN + info.a_len;
  memcpy(buf + idx, &SEPARATOR, SEPARATOR_LEN);
  idx += SEPARATOR_LEN;
  write_nucleotide(buf + idx, 'C', info.c_cnt, info.c_len);
  idx += HEADER_LEN + info.c_len;
  memcpy(buf + idx, &SEPARATOR, SEPARATOR_LEN);
  idx += SEPARATOR_LEN;
  write_nucleotide(buf + idx, 'G', info.g_cnt, info.g_len);
  idx += HEADER_LEN + info.g_len;
  memcpy(buf + idx, &SEPARATOR, SEPARATOR_LEN);
  idx += SEPARATOR_LEN;
  write_nucleotide(buf + idx, 'T', info.t_cnt, info.t_len);

  buf[total_len - 1] = 0;
  return buf;
}

u8 u32_len(u32 n) {
  if (n == 0)
    return 1;

  u8 count = 0;
  while (n != 0) {
    n /= 10;
    count++;
  }

  return count;
}

void write_nucleotide(char *buf, char nucleotide, u32 cnt, u8 cnt_len) {
  char header[HEADER_LEN];
  for (u8 i = 0; i < HEADER_LEN; i++)
    header[i] = HEADER[i];
  header[0] = nucleotide;

  memcpy(buf, header, HEADER_LEN);
  write_u32(buf + HEADER_LEN, cnt, cnt_len);
}

void write_u32(char *buf, u32 n, u8 l) {
  u8 i = l - 1;
  do {
    buf[i] = n % 10 + '0';
    n /= 10;
    i--;
  } while (n != 0);
}
