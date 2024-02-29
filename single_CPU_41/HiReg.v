//乘法寄存器高32位寄存器
module HiReg(Clk,WE,Hin,Hout);

input Clk;
input WE;
input [31:0] Hin;
output [31:0] Hout;

//定义寄存器
reg [31:0] HiReg;

//寄存器初始化
initial begin
	HiReg<=31'd0;
end

//取数
assign Hout=HiReg;

//存入数据
always@(posedge Clk) begin
	if(WE) begin
		HiReg<=Hin;
	end
end

endmodule
