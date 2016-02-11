/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include "sys/alt_stdio.h"
#include "system.h"
#include "altera_avalon_fifo_regs.h"
#include "altera_avalon_fifo_util.h"
#include <stdio.h>
#include <stddef.h>
#include <stdlib.h>


int main(void)
{
/*****************************************************************************/
//  Open run length file
  FILE *fp = NULL;
  alt_u32 rData;
  int i = 0;
  alt_u32 iData, oData;
  int iEna = 0;

  printf("test_start\n");

  fp = fopen("/mnt/host/learning.txt", "r");

  if(fp == NULL)
  {
    printf("Cannot open file.\n");
    exit(1);
  }

/*****************************************************************************/
//  Write to FIFO
  int k;
  for(i = 0; i < 1000; i++)
  {
    if(iEna) break;
    else
    {
      fscanf(fp, "%x", &rData);
      iData = rData;
      printf("%08x\n", iData);
      iEna = altera_avalon_fifo_write_fifo(0x41094, 0x41060, iData);
    }
  }

  for(k = 0; k < 1000; k++)
  {
    oData = altera_avalon_fifo_read_fifo(0x41090, 0x41040);
    if(oData) printf("%x ", oData);
  }


/*****************************************************************************/
//  Finish process
  return 0;
}
