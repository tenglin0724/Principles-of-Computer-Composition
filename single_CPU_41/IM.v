//指令存储器
module IM(Addr,Dout);

input [31:0] Addr;														//输入的地址
output reg [31:0] Dout;											//输出的指令字

//定义指令存储器
reg [31:0] im [1023:0];																			

//开始时直接将指令全读入指令存储器中
initial $readmemb("code.txt",im,0);

//读出指令
always@(*) begin
	Dout<=im[Addr[11:2]];
end

endmodule

