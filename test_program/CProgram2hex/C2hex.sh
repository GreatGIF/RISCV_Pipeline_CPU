riscv64-unknown-elf-gcc -c -march=rv32i -mabi=ilp32 init.s -o init.o
riscv64-unknown-elf-gcc -c -march=rv32i -mabi=ilp32 main.c -o main.o
riscv32-unknown-linux-gnu-ld -T link.ld -o test.elf init.o main.o
riscv64-unknown-linux-gnu-objdump -d test.elf > test.lst
riscv64-unknown-linux-gnu-objcopy -O verilog --only-section ".text*"  test.elf --set-start=0x0 ../../src/data/inst.hex
riscv64-unknown-linux-gnu-objcopy -O verilog --only-section ".data*" --only-section ".rodata*" test.elf --set-start=0x0 ../../src/data/data.hex
rm init.o
rm main.o
rm test.elf
echo "Success!"
