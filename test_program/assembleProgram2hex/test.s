.section .text
.global _start
_start:

   # set base address for data access
   la x2, data_seg #load data_seg

main:
   li x5, 0x0
   addi x5, x5, 0x1
   li x2, 0x0
   sw x5, 0(x2)
   li x3, 0x1
   lw x5, 0(x2)
   bne x3, x5, fail
   
   j  pass


fail:
   beq x0, x0, fail

pass:
   beq x0, x0, pass



.data
data_seg:
.word 0xaaaaaaaa
.word 0x55555555
.word 0xcccccccc
.word 0x33333333
.word 0x00000000
.word 0x00000000
.word 0x00000000
.word 0x00000000

