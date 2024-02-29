//测试文件
`timescale 1ns/1ns

module tcpu;

reg clk,reset;

//初始化

MIPS mips(clk,reset);

initial begin
	reset=0;clk=0;
	#30;
	reset=1;
	#1000;
	$stop;
end

always begin
	#5 clk=!clk;
end

endmodule




