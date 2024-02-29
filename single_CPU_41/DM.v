//数据存储器
module DM(WrEn,Adr,DataIn,Clk,Boperation,DataOut);

input WrEn;
input Clk;											
input [31:0] Adr;
input [31:0] DataIn;									//输入的地址（一定为4的倍数）和输入的数据
input [1:0] Boperation;
output reg [31:0] DataOut;								//输出的数据

//定义存储器(按位存储)
reg [31:0] dm [1023:0];									

//定义辅助的变量
integer id;
initial begin
	for(id=0;id<1023;id=id+1) begin
		dm[id]<=0;
	end
end

always@(*) begin
	if(Boperation==2'b00)														//如果对一个字进行操作
		DataOut<=dm[Adr[11:2]];
	else if(Boperation==2'b11) begin
		case(Adr[1:0])
			2'b00:DataOut<={ {24{dm[Adr[11:2]][7]}} , dm[Adr[11:2]][7:0] };
			2'b01:DataOut<={ {24{dm[Adr[11:2]][15]}} , dm[Adr[11:2]][15:8] };
			2'b10:DataOut<={ {24{dm[Adr[11:2]][23]}} , dm[Adr[11:2]][23:16] };
			2'b11:DataOut<={ {24{dm[Adr[11:2]][31]}} , dm[Adr[11:2]][31:24] };
		endcase
	end
	else if(Boperation==2'b10) begin													//lbu指令做0扩展
		case(Adr[1:0])
			2'b00:DataOut<=dm[Adr[11:2]][7:0];
			2'b01:DataOut<=dm[Adr[11:2]][15:8];
			2'b10:DataOut<=dm[Adr[11:2]][23:16];
			2'b11:DataOut<=dm[Adr[11:2]][31:24];
		endcase		
	end
end

//读写
always@(posedge Clk) begin
	if(WrEn) begin
		if(Boperation[1]==0) 										     		//sw指令
			dm[Adr[11:2]]<=DataIn;
		else if(Boperation[1]==1)
			begin
				case(Adr[1:0])
					2'b00:dm[Adr[11:2]][7:0]<=DataIn[7:0];
					2'b01:dm[Adr[11:2]][15:8]<=DataIn[7:0];	
					2'b10:dm[Adr[11:2]][23:16]<=DataIn[7:0];
					2'b11:dm[Adr[11:2]][31:24]<=DataIn[7:0];	
				endcase
			end								
	end
end
endmodule
