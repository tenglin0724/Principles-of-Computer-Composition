//乘法低31位寄存器
module LoReg(Clk,WE,Lout,Loin);

input Clk;													//时钟信号
input WE;													//写使能信号
input [31:0] Loin;													//低位输入信号
output [31:0] Lout; 												//寄存器内容输出

reg [31:0] loreg;											//定义低32位寄存器

//初始化
initial begin
	loreg<=32'd0;
end

//读数据
assign Lout=loreg;

//写数据
always@(posedge Clk) begin
	if(WE) begin
		loreg<=Loin;
	end
end

endmodule




