//ALU模块
module ALU(ALUCtr,busA,busB,Shamt,Imm,Of,Zero,Result,LoRe,HiRe);

//输入输出定义
input [4:0] ALUCtr;														//ALU控制信号
input [31:0] busA;														//ALUA输入端
input [31:0] busB;														//ALUB输入端
input [15:0] Imm;														//立即数装载（lui指令需要）
input [4:0] Shamt;														//移位操作
output reg Of;															//溢出标志
output reg Zero;														//运算结果是否为零							
output reg [31:0] Result;												//要输出的运算结果
output reg [31:0] LoRe;													//低位寄存器
output reg [31:0] HiRe;													//高位寄存器

//功能实现
always@(*) begin
	Of<=0;
	case(ALUCtr)
		5'b00000: begin													//addu操作加不用考虑溢出
					Result<=busA+busB;
				end
		5'b00001: begin													//add操作
					Result<=busA+busB;
					Of<= (busA[31]&busB[31]&(~Result[31])+(~busA[31])&(~busB[31])&Result[31]);
				end
		5'b00010: begin													//or操作
					Result<=busA|busB;
				end
		5'b00011: begin													//subu操作
					Result<=busA-busB;
				end
		5'b00100: begin													//sub操作
					Result<=busA+(~busB)+1;
				end
		5'b00101: begin													//slt操作（比较带符号数busA和busB的大小）
					Result<=($signed(busA)<$signed(busB))? 32'd1:32'd0;
				end
		5'b00110: begin													//and操作
					Result<=busA&busB;
				end
		5'b00111: begin													//nor操作：按位或非
					Result<=~(busA|busB);
				end
		5'b01001: begin													//xor：按位异或
					Result<=busA^busB;	
				end
		5'b01010: begin													//sll：逻辑左移
					Result<=busB<<Shamt;
				end	
		5'b01011: begin													//srl：逻辑右移
					Result<=busB>>Shamt;
				end
		5'b01100: begin													//sltu：无符号数比较置位
					Result<=(busA<busB)?32'd1:32'd0;
				end
		5'b01111: begin													//sllv：左移busA位
					Result<=busB<<busA;
				end
		5'b10000: begin													//算术右移
					Result<=$signed(busB)>>>Shamt;
				end
		5'b10001: begin													//变量算术右移
					Result<=$signed(busB)>>>busA;
				end
		5'b10010: begin													//变量逻辑右移
					Result<=busB>>busA;
				end
		5'b10011: begin													//高位装载
					Result<={Imm,16'd0};
				end
		5'b10100: begin													//slti比较带符号数busA和Imm大小
					Result<=($signed(busA)<{{16{Imm[15]}},Imm})?32'd1:32'd0;
				end
		5'b10101: begin													//比较busA和Imm大小（无符号比较）
					Result<=(busA<{{16{Imm[15]}},Imm})?32'd1:32'd0;
				end
		5'b10110: begin
					{HiRe,LoRe}<=$signed(busA)*$signed(busB);				//有符号乘法
				end
		5'b10111: begin													//MTLO
					LoRe<=busA;
				end
		5'b11000: begin													//MTHI
					HiRe<=busA;
				end
		//待拓展		
		default: begin
					LoRe<=32'd0;HiRe<=32'd0;Result<=32'd0;
				end
	endcase
	
	//判断溢出和0标志位是否成立
	Zero<= (Result==32'd0)? 1 : 0;
end

endmodule

