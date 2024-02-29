//NPC模块
module NPC(Reset,Jump,Zero,Imm,Target,Address,NPC,Op,Branch,Rt,Funct,busA,thirty_first);

input Reset;
input Jump;
input Zero;
input Branch;
input [31:0] Address;
input [15:0] Imm;
input [25:0] Target;
input [5:0] Op;
input [5:0] Funct;
input [4:0] Rt;
input [31:0] busA;

output reg [31:0] NPC;
output reg [31:0] thirty_first;	
																					//第31号寄存器要存储的
reg [31:0] PC;																		//这里的PC相当于一个中间变量
wire [31:0] Ext_imm;

//赋初值
initial begin
	PC<=32'h0000_3000;
	thirty_first<=32'd0;
end

assign Ext_imm={ {14{Imm[15]}} ,Imm,2'b00};												//做符号扩展

always@(*) begin
	if(!Reset)
		PC<=32'h0000_3000;
	else
		PC<=Address+4;
	case(Op)
		6'b000101: begin																//bne指令
					if((!Zero)&&Branch)
						NPC<=Address+Ext_imm;
					else
						NPC<=PC;
				end
		6'b000100: begin																//beq指令
					if(Zero&&Branch) 
						NPC<=Address+Ext_imm;
					else
						NPC<=PC;	
				end
		6'b000111: begin																//bgtz指令
					if(Branch&&(busA!==32'd0)&&(busA[31]==0))
						NPC<=Address+Ext_imm;
					else
						NPC<=PC;
				end
		6'b000110: begin																//blez
					if(Branch&&(busA==32'd0)|(busA[31]==1))
						NPC<=Address+Ext_imm;
					else
						NPC<=PC;
				end
		6'b000001: begin																//bgez和bltz
					if(Branch) begin
						if(Rt==5'd1)													//bgez（大于等于跳转）
							NPC<=((busA==32'd0)|(busA[31]==0)) ? Address+Ext_imm:PC;
						else 
							NPC<= busA[31] ? Address+Ext_imm:PC;						//bltz（小于0跳转）
					end
				end
		6'b000000: begin
					if(Jump) begin
						NPC<=busA+32'h0000_3000;
						if(Funct==6'b001001)											//jalr要将pc+4存到31中
							thirty_first<=PC;
					end
					else 																//r型其他指令正常执行
						NPC<=PC;
				end
		6'b000011: begin																//jal指令
					if(Jump) begin
						NPC<={PC[31:28],Target,{2'b00}}+32'h0000_3000;
						thirty_first<=PC;
					end
				end
		6'b000010: begin																//j指令
					if(Jump) begin	
						NPC<={PC[31:28],Target,{2'b00}}+32'h0000_3000;
					end
				end
		default :
				NPC<=PC;																//默认情况下
	endcase
end
endmodule

