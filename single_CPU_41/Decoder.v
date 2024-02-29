//译码单元
module Decoder(Instruction,Op,Funct,Rs,Rt,Rd,Imm,Shamt,Target);

//这里的输入输出已经在Control得到详细描述
input [31:0] Instruction;						
output [5:0] Op;
output [5:0] Funct;								
output [4:0] Rs;
output [4:0] Rt;
output [4:0] Rd;
output [4:0] Shamt;					
output [15:0] Imm;								
output [25:0] Target;	

//进行译码
assign {Op,Rs,Rt,Rd,Shamt,Funct}=Instruction;
assign Imm=Instruction[15:0];
assign Target=Instruction[25:0];

endmodule