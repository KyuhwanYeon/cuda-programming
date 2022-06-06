
#include "test.h"

__global__ void add(float a, float b, float *c)
{
  *c = a + b;
}

__global__ void array_add(float *a, float *b, float *c, int N)
{
  int tid = blockIdx.x;
  if (tid < N)
  {
    c[tid] = a[tid] + b[tid];
  }
}

void test_add(float a, float b)
{
  // prefix dev_ : device
  float c;
  float *dev_c;
  cudaMalloc(&dev_c, sizeof(float));

  add<<<1, 1>>>(a, b, dev_c);

  cudaMemcpy(&c, dev_c, sizeof(float), cudaMemcpyDeviceToHost);

  // Copy results back from device.
  std::printf("%f + %f = %f \n", a, b, c);

  cudaFree(dev_c);
}

void test_array_add(float *a, float *b, int N)
{

  float c[N];
  float *dev_a, *dev_b, *dev_c;
  cudaMalloc(&dev_a, sizeof(float) * N);
  cudaMalloc(&dev_b, sizeof(float) * N);
  cudaMalloc(&dev_c, sizeof(float) * N);

  cudaMemcpy(dev_a, a, sizeof(a), cudaMemcpyHostToDevice);
  cudaMemcpy(dev_b, b, sizeof(b), cudaMemcpyHostToDevice);

  array_add<<<N, 1>>>(dev_a, dev_b, dev_c, N);

  cudaMemcpy(c, dev_c, sizeof(c), cudaMemcpyDeviceToHost);

  cudaFree(dev_a);
  cudaFree(dev_b);
  cudaFree(dev_c);

  for (int i = 0; i < N; i++)
  {
    std::printf("%f + %f = %f \n", a[i], b[i], c[i]);
  }
}