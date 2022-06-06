#include <cstdio>
#include <cstdlib>

#include "test.h"

int main(void)
{
  printf("\n######################## \n");
  printf("Test 1: Single value add \n");
  printf("######################## \n");
  float sum;
  test_add(2, 7);
  printf("\n######################## \n");
  printf("Test 2: Array add \n");
  printf("######################## \n");
  const int N = 10; // Array size
  float a[N], b[N];
  for (int i = 0; i < N; i++) // Set test inputs
  {
    a[i] = i + 2;
    b[i] = i - 2;
  }
  test_array_add(a, b, N);

  return EXIT_SUCCESS;
}
