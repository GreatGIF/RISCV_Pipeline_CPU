riscv64-unknown-elf-as -mabi=ilp32 -march=rv32i ./test.s -o ./test.elf
riscv64-unknown-linux-gnu-objdump -d ./test.elf > ./test.lst
riscv64-unknown-linux-gnu-objcopy -O verilog --only-section ".text*"  ./test.elf --set-start=0x0 ../../src/data/inst.hex
riscv64-unknown-linux-gnu-objcopy -O verilog --only-section ".data*" --only-section ".rodata*" ./test.elf --set-start=0x0 ../../src/data/data.hex
echo "Success!"
