//PC模块
module PC(Clk,Reset,NPC,PC_out);

input Clk;
input Reset;
input [31:0] NPC;									//输入的地址

output reg [31:0] PC_out;							//计算得到的地址

//初始值
initial begin
	PC_out=32'd0;
end

//当时钟信号变化后写入PC
always@(posedge Clk) begin
	if(Reset) begin
			PC_out<=NPC;
		end
	else begin
			PC_out<=32'd0;
		end								
end
endmodule

