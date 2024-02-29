//控制信号生成器
module Control_signal(Op,Funct,RegDst,ALUSrc,MemtoReg,RegWrite,MemWrite,Branch,Jump,ExtOp,ALUCtr,Boperation,MFLO,MFHI,MTLO,MTHI);

//相关输入输出已经在Control中得到详细描述，这里不多赘述
input [5:0] Op;													
input [5:0] Funct;

output reg RegDst;
output reg ALUSrc;
output reg MemtoReg;
output reg RegWrite;
output reg MemWrite;
output reg Branch;
output reg Jump;
output reg ExtOp;
output reg MFLO;
output reg MFHI;
output reg MTLO;
output reg MTHI;
output reg [1:0] Boperation;
output reg [4:0] ALUCtr;

always@(*) begin
	case(Op) 
		6'b000000: begin													//R型指令
					Boperation<=0;Branch<=0;RegDst<=1;ALUSrc<=0;MemtoReg<=0;MemWrite<=0;ExtOp<=0;
					case(Funct)
						6'b100000: begin									//add指令
									Jump<=0;ALUCtr<=5'b00001;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100001: begin									//addu指令
									Jump<=0;ALUCtr<=5'b00000;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100010: begin									//sub指令
									Jump<=0;ALUCtr<=5'b00100;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100011: begin									//subu指令
									Jump<=0;ALUCtr<=5'b00011;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b101010: begin									//slt指令(比较两个寄存器值的大小)
									Jump<=0;ALUCtr<=5'b00101;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100100: begin									//and指令
									Jump<=0;ALUCtr<=5'b00110;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100111: begin									//nor指令(按位或非)
									Jump<=0;ALUCtr<=5'b00111;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100101: begin									//or指令(按位或)
									Jump<=0;ALUCtr<=5'b00010;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b100110: begin									//xor指令(按位异或)
									Jump<=0;ALUCtr<=5'b01001;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b000000: begin									//SLL指令(逻辑左移)
									Jump<=0;ALUCtr<=5'b01010;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b000010: begin									//SrL指令(逻辑右移)
									Jump<=0;ALUCtr<=5'b01011;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b101011: begin									//SLtu指令(无符号数比较置位)
									Jump<=0;ALUCtr<=5'b01100;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b001001: begin									//jalr指令
									Jump<=1;ALUCtr<=5'b00000;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b001000: begin									//jr指令
									Jump<=1;ALUCtr<=5'b00000;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b000100: begin									//SLLV指令(变量逻辑左移)
									Jump<=0;ALUCtr<=5'b01111;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b000011: begin									//Sra指令(算数右移)
									Jump<=0;ALUCtr<=5'b10000;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b000111: begin									//Srav指令(变量算数右移)
									Jump<=0;ALUCtr<=5'b10001;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b000110: begin									//Srlv指令(变量逻辑右移)
									Jump<=0;ALUCtr<=5'b10010;RegWrite<=1;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end		   
						6'b011000: begin									//MULT
									Jump<=0;ALUCtr<=5'b10110;RegWrite<=0;MFHI<=0;MFLO<=0;MTHI<=1;MTLO<=1;				//有符号乘法
								   end
						6'b010010: begin									//MFLO
									Jump<=0;ALUCtr<=5'b00000;RegWrite<=1;MFHI<=0;MFLO<=1;MTHI<=0;MTLO<=0;
								   end
						6'b010000: begin									//MFHI
									Jump<=0;ALUCtr<=5'b00000;RegWrite<=1;MFHI<=1;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
						6'b010011: begin									//MTLO
									Jump<=0;ALUCtr<=5'b10111;RegWrite<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=1;
									end
						6'b010001: begin									//MTHI
									Jump<=0;ALUCtr<=5'b11000;RegWrite<=0;MFHI<=0;MFLO<=0;MTHI<=1;MTLO<=0;
									end	
						
						default:   begin
									Jump<=0;ALUCtr<=5'b00000;RegWrite<=0;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
								   end
					endcase
				   end
		6'b001101: begin			//ori指令
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=0;ALUCtr<=5'b00010;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001000: begin			//addi指令
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=1;ALUCtr<=5'b00001;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b100011: begin			//lw指令
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=1;RegWrite<=1;MemWrite<=0;ExtOp<=1;ALUCtr<=5'b00000;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b101011: begin			//sw指令
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=0;MemWrite<=1;ExtOp<=1;ALUCtr<=5'b00000;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b000100: begin			//beq指令
					Branch<=1;Jump<=0;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=0;ALUCtr<=5'b00011;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001001: begin			//addiu指令
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=1;ALUCtr<=5'b00000;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b000101: begin			//bne指令
					Branch<=1;Jump<=0;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=0;ALUCtr<=5'b00011;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001111: begin			//lui指令
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=0;ALUCtr<=5'b10011;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001010: begin			//slti指令
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=1;ALUCtr<=5'b10100;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001011: begin			//sltiu指令(有问题)
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=1;ALUCtr<=5'b10101;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b000001:  begin			//bgez指令或者bltz指令
					Branch<=1;Jump<=0;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=0;ALUCtr<=0;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b000111:  begin			//bgtz指令
					Branch<=1;Jump<=0;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=0;ALUCtr<=0;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b000110:  begin			//blez指令
					Branch<=1;Jump<=0;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=0;ALUCtr<=0;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001100:  begin			//andi指令
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=0;ALUCtr<=5'b00110;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001101:  begin			//ori指令
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=0;ALUCtr<=5'b01000;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b001110:  begin			//xori指令
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=0;ALUCtr<=5'b01001;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b000010:  begin			//j指令
					Branch<=0;Jump<=1;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=0;ALUCtr<=0;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end	
		6'b000011:  begin			//jal指令
					Branch<=0;Jump<=1;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=1;MemWrite<=0;ExtOp<=0;ALUCtr<=0;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b100000:  begin			//lb指令(待完善)
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=1;RegWrite<=1;MemWrite<=0;ExtOp<=1;Boperation<=2'b11;ALUCtr<=5'b00001;Boperation<=2'b11;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b100100:  begin			//lbu指令(待完善)
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=1;RegWrite<=1;MemWrite<=0;ExtOp<=1;Boperation<=2'b10;ALUCtr<=5'b00000;Boperation<=2'b10;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		6'b101000: begin			//sb指令(待完善)
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=1;MemtoReg<=0;RegWrite<=0;MemWrite<=1;Boperation<=2'b10;ExtOp<=1;ALUCtr<=5'b00001;Boperation<=2'b11;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
		default:   begin
					Branch<=0;Jump<=0;RegDst<=0;ALUSrc<=0;MemtoReg<=0;RegWrite<=0;MemWrite<=0;ExtOp<=0;ALUCtr<=5'd0;Boperation<=2'b00;MFHI<=0;MFLO<=0;MTHI<=0;MTLO<=0;
				   end
	endcase
end

endmodule