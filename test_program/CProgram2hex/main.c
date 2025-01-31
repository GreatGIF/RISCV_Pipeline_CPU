/*裸机中运行C程序，仅能使用riscv基本指令集，不能引用标准库中的函数，如 printf。*/

int main() {
	int a = 100;
	int b = 64;
	int c = 0;
	if((a==0) || (b==0)) { c = 0;}
	else{
		while(b != 0){
			c = c + a;
			b = b - 1;
		}
	}
	while(1){} //死循环，相当于停机。
	return 0;
}
