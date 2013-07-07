/* Simple semi-hosted hello world. */

.section .text, "ax"
.global _start
_start:
ldr     w1, =hello
movz    w0, #0x04    /* SWI: write0   */
hlt     #0xf000
movz    w0, #0x18    /* SWI: Exit     */
hlt     #0xf000
b       .            /* Infinite loop */

hello:
  .ascii "Hello, world!\n"
