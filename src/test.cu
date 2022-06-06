
#include "test.h"

__global__ void add(float a, float b, float *c)
{
  *c = a + b;
}

void test_add(float a, float b, float &c)
{
  float *dev_c;
  cudaMalloc(&dev_c, sizeof(float));

  add<<<1, 1>>>(a, b, dev_c);

  // Copy vectors to device
  cudaMemcpy(&c, dev_c, sizeof(float), cudaMemcpyDeviceToHost);

  // Copy results back from device.
  std::printf("%f + %f = %f \n", a, b, c);

  cudaFree(dev_c);
}
