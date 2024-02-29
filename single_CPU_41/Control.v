//控制单元
module Control(Clk,Reset,Rt,Rs,Rd,RegWr,ALUCtr,Imm,Shamt,Op,Funct,Target,ExtOp,ALUSrc,MemtoReg,MemWr,RegDst,Boperation,MFHI,MFLO,MTHI,MTLO,Branch,Jump,Instruction);

input Clk;																		//时钟信号
input Reset;																	//复位信号
input [31:0] Instruction;														//数据通路中取指得到的指令																

output RegWr;																	//寄存器写信号
output ExtOp;																	//扩展方式控制信号
output ALUSrc;																	//选择busB进入数据信号
output MemtoReg;																//选择busW_in进入信号
output MemWr;																	//存储器写信号
output Branch;																	//分支指令信号
output Jump;																	//j型指令信号
output RegDst;																	//控制目标寄存器是rd还是rt
output MFHI;																	//从hi寄存器中取数
output MFLO;																	//从lo寄存器中取数
output MTHI;																	//村存数到hi寄存器
output MTLO;																	//存数到lo寄存器
output [4:0] ALUCtr;															//ALU控制信号，控制在数据通路中的ALU
output [15:0] Imm;																//十六位立即数														
output [1:0] Boperation;														//控制读取数据是一个字还是字节，以及读取后的扩展方式
output [25:0] Target;															//j型指令跳转地址的一部分
output [5:0] Op;																//OP控制信号		
output [5:0] Funct;																//Funct域，与R型指令关系较大
output [4:0] Rs;																//源寄存器（一般对应busA）
output [4:0] Rt;																//源寄存器或者是目标寄存器
output [4:0] Rd;																//目标寄存器
output [4:0] Shamt;																//移位数据，交给ALU使用

//调用译码单元
Decoder dec(
	.Instruction(Instruction),
	.Op(Op),
	.Funct(Funct),
	.Rs(Rs),
	.Rt(Rt),
	.Rd(Rd),
	.Imm(Imm),
	.Shamt(Shamt),
	.Target(Target)
);

//调用控制器生成信号单元
Control_signal cs(
	.Op(Op),
	.Funct(Funct),
	.RegWrite(RegWr),
	.RegDst(RegDst),
	.ALUSrc(ALUSrc),
	.ALUCtr(ALUCtr),
	.MemtoReg(MemtoReg),
	.MemWrite(MemWr),
	.ExtOp(ExtOp),
	.Branch(Branch),
	.Jump(Jump),
	.Boperation(Boperation),
	.MFHI(MFHI),
	.MFLO(MFLO),
	.MTHI(MTHI),
	.MTLO(MTLO)
);

endmodule



