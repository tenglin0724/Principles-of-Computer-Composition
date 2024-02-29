//单周期cpu
module MIPS(Clk,Reset);
input Clk;								//时钟周期
input Reset;							//复位信号
wire RegWr;								//寄存器堆写使能信号
wire RegDst;							//目标寄存器选通信号
wire ExtOp;								//扩展选通信号
wire ALUSrc;							//ALU操作数选通信号
wire MemtoReg;							//写入寄存器数据选通信号
wire MemWr;								//存储器写使能
wire Jump;								//Jump跳转指令信号
wire MFHI;								//hi寄存器命令控制信号
wire MFLO;								//lo寄存器命令控制信号
wire MTHI;								//存数据到hi寄存器
wire MTLO;								//存数据到lo寄存器
wire [1:0] Boperation;					//存储器访问控制信号
wire [5:0] Op;							//Op域
wire [5:0] Funct;						//Funct域
wire [4:0] ALUCtr;						//ALU运算的控制信号
wire [4:0] Rt;							//源寄存器地址
wire [4:0] Rs;							//源寄存器地址
wire [4:0] Rd;							//目标寄存器地址
wire [4:0] Shamt;						//移位操作的移位数
wire [15:0] Imm;						//16位立即数
wire [25:0] Target;						//j跳转目标
wire [31:0] Instruction;				//指令


//例化控制单元
Control wc(
	.Clk(Clk),
	.Reset(Reset),
	.RegWr(RegWr),
	.ALUCtr(ALUCtr),
	.Rt(Rt),
	.Rd(Rd),
	.Rs(Rs),
	.Imm(Imm),
	.Shamt(Shamt),
	.ExtOp(ExtOp),
	.ALUSrc(ALUSrc),
	.MemtoReg(MemtoReg),
	.MemWr(MemWr),
	.RegDst(RegDst),
	.Branch(Branch),
	.Jump(Jump),
	.Boperation(Boperation),
	.MFHI(MFHI),
	.MFLO(MFLO),
	.MTHI(MTHI),
	.MTLO(MTLO),
	.Instruction(Instruction),
	.Target(Target),
	.Op(Op),
	.Funct(Funct)
);


//例化数据通路
Datapath dp(
	.Clk(Clk),
	.Reset(Reset),
	.Rs(Rs),
	.Rd(Rd),
	.Rt(Rt),
	.Imm(Imm),
	.Shamt(Shamt),
	.ALUCtr(ALUCtr),
	.RegWr(RegWr),
	.RegDst(RegDst),
	.ExtOp(ExtOp),
	.ALUSrc(ALUSrc),
	.MemtoReg(MemtoReg),
	.MemWr(MemWr),
	.Jump(Jump),
	.Branch(Branch),
	.Boperation(Boperation),
	.Instruction(Instruction),
	.Target(Target),
	.Op(Op),
	.Funct(Funct),
	.MFHI(MFHI),
	.MFLO(MFLO),
	.MTHI(MTHI),
	.MTLO(MTLO)
);

endmodule
