//数据通路模块
module Datapath(Clk,Reset,RegWr,Rs,Rt,Rd,Imm,Shamt,Op,Funct,Target,ALUCtr,RegDst,Branch,ExtOp,ALUSrc,MemtoReg,MemWr,Boperation,Jump,Instruction,MFHI,MFLO,MTHI,MTLO);

input Clk;
input Reset;
input RegWr;												//与Of构成寄存器写使能信号
input RegDst;												//选rd或rt
input ExtOp;												//扩展方式选择
input ALUSrc;												//busB选择
input MemtoReg;												//busW选择
input MemWr;												//存储器写使能
input Jump;													//跳转信号
input MFHI;
input MFLO;
input MTHI;
input MTLO;
input Branch;												//分支控制信号
input [15:0] Imm;											//立即数
input [4:0] Rs;
input [4:0] Rt;
input [4:0] Rd;
input [4:0] Shamt;
input [4:0] ALUCtr;
input [25:0] Target;
input [5:0] Op;
input [5:0] Funct;
input [1:0] Boperation;		
								
output [31:0] Instruction;

//一些临时变量
wire Of;													//ALU运算是否溢出
wire WE;													//寄存器写使能信号
wire Zero;
wire [31:0] LoRe;											//ALU输出的结果
wire [31:0] HiRe;											//ALU输出的结果
wire [31:0] Hout;											//从hi寄存器中得到的数据
wire [31:0] Lout;											//从lo寄存器中得到的数据
wire [31:0] busA;
wire [31:0] busB;											//根据寄存器编号从寄存器堆中取出的操作数,以及最终通过数据选择器后要输入ALU的busB
wire [31:0] Result;											//ALU运算结果
wire [31:0] Nextresult;										//下一条指令地址
wire [31:0] DataOut;										//数据存储器输出结果
wire [31:0] thirty_first;									//jalr和jal指令要存入31号寄存器的值
wire [31:0] Address;										//NPC计算的指令地址，根据地址值取出指令

reg [4:0] Rw;												//寄存器的写端口
reg [31:0] Imm_ext;											//扩展后的立即数(用于ALU运算)
reg [31:0] busW_in;											//busw的真实输入														
reg [31:0] busB_in;											//busB的真实输入


//生成寄存器写使能信号
assign WE=(~Of)&RegWr;


//这些是选通器
always@(*) begin
	//选择扩展方式：
	if(ExtOp)												//符号扩展
		Imm_ext<={ {16{Imm[15]}} ,Imm};
	else 													//0扩展（默认）
		Imm_ext<=Imm;
	
	//选择目标寄存器：
	if(RegDst) 												//选择rd为目标寄存器
		Rw<=Rd;
	else 													//选择rt为目标寄存器
		Rw<=Rt;
	
	//选择输入busB的数据：
	if(ALUSrc)												//选择扩展后的数为busB
		busB_in<=Imm_ext;
	else 													//选择rt寄存器的内容为busB
		busB_in<=busB;
	
	//选择要写入寄存器的数据
	if(MemtoReg)											//lw写
		busW_in<=DataOut;
	else if(Jump&&RegWr)									//jr型指令写入31号寄存器
		begin
			busW_in<=thirty_first;
			Rw<=5'd31;
		end
	else if(MFHI)											//从hi取数，存入寄存器中
		busW_in<=Hout;
	else if(MFLO)											//从lo取数，存入寄存器中
		busW_in<=Lout;
	else													//一般的r型指令或者i型指令
		busW_in<=Result;
end

//例化寄存器堆
Register rg(
	.Clk(Clk),
	.WE(WE),											
	.Rw(Rw),
	.Ra(Rs),
	.Rb(Rt),
	.busA(busA),
	.busB(busB),
	.busW(busW_in)
);
//实例化HiReg模块
HiReg hr(
	.Clk(Clk),
	.WE(MTHI),
	.Hin(HiRe),
	.Hout(Hout)
);

//实例化LoReg模块
LoReg lr(
	.Clk(Clk),
	.WE(MTLO),
	.Loin(LoRe),
	.Lout(Lout)
);

//例化ALU模块
ALU alu(
	.ALUCtr(ALUCtr),
	.busA(busA),
	.busB(busB_in),
	.Shamt(Shamt),
	.Imm(Imm),
	.Result(Result),
	.Of(Of),
	.Zero(Zero),
	.LoRe(LoRe),
	.HiRe(HiRe)
);

//例化数据存储器模块
DM dm(
	.WrEn(MemWr),
	.Adr(Result),
	.Boperation(Boperation),
	.DataIn(busB),
	.Clk(Clk),
	.DataOut(DataOut)
);

//实例化指令存储器
IM im(
	.Addr(Address),
	.Dout(Instruction)
);

//实例化NPC模块
NPC npc(
	.Reset(Reset),
	.Jump(Jump),
	.Branch(Branch),
	.Rt(Rt),
	.Imm(Imm),
	.Target(Target),
	.busA(busA),
	.Address(Address),
	.Op(Op),
	.Funct(Funct),
	.NPC(Nextresult),
	.thirty_first(thirty_first),
	.Zero(Zero)
);

//实例化PC模块
PC pc(
	.Clk(Clk),
	.Reset(Reset),
	.NPC(Nextresult),
	.PC_out(Address)
);


initial begin
$monitor("the Address=%h,the Rs=%b,the Rt=%b,the busA=%b,the busB_in=%b,the rusult=%d,the WrEn=%d,the busW_in",Address,Rs,Rt,busA,busB_in,Result,MemWr,busW_in);
end
endmodule
