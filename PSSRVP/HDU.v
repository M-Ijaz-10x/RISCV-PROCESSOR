module HDU #(parameter AWIDTH = 32)(
	//INPUTS TO THE HDU
	input [AWIDTH-1:0] Instr_D,
	input [AWIDTH-1:0] Instr_X,
	input MemRWE,
	input [3:0] ALUSel,
	input [1:0] BSel,
	input [2:0] ILoad,
	input [1:0] WBSel,
	input RegWEn,
	input MemRW,
	input PCSel,
	input [1:0] ASel,
	input BrUn,

	//OUTPUTS FROM THE HDU
	output reg PC_H,
	output reg ID_H,
	output reg [3:0] ALUSel_H,
	output reg [1:0] BSel_H,
	output reg [2:0] ILoad_H,
	output reg [1:0] WBSel_H,
	output reg RegWEn_H,
	output reg MemRW_H,
	output reg PCSel_H,
	output reg [1:0] ASel_H,
	output reg BrUn_H
);
	always @ * begin
		if ( (Instr_X[6:0] == 7'b0000011) && ((Instr_X[11:7] == Instr_D[24:20]) || (Instr_X[11:7] == Instr_D[19:15]) && Instr_X[11:7]!=5'b0)) begin
			PC_H = 1'b1;
			ID_H = 1'b1;
			ALUSel_H = 4'b0000;
			BSel_H = 2'b00;
			ILoad_H = 3'b000;
			WBSel_H = 2'b00;
			RegWEn_H = 0;
			MemRW_H = 0;
			PCSel_H = 0;
			ASel_H = 2'b00;
			BrUn_H = 0;
		end
		else begin
			PC_H = 0;
			ID_H = 0;
			ALUSel_H = ALUSel;
			BSel_H = BSel;
			ILoad_H = ILoad;
			WBSel_H = WBSel;
			RegWEn_H = RegWEn;
			MemRW_H = MemRW;
			PCSel_H = PCSel;
			ASel_H = ASel;
			BrUn_H = BrUn;
		end
	end
	
endmodule
