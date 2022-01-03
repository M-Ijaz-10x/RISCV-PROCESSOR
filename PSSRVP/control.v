module control #(parameter WIDTH = 5, AWIDTH = 32, DWIDTH = 32)(
	
	//INPUT TO THE CONTROLLER
	input [DWIDTH-1:0] instr,
	input BrEq, BrLT,

	//OUTPUTS FROM THE CONTROLLER
	output reg [WIDTH-1:0] ALUSel,
	output reg BSel,
	output reg [2:0] ILoad,
	output reg [1:0] WBSel,
	output reg RegWEn,
	output reg MemRW,
	output reg PCSel,
	output reg ASel,
	output reg BrUn
);
	//SOME EXTRA NETS NEEDED
	wire [6:0] opcode;
	wire [2:0] func3;
	wire [6:0] func7;

	//NETS ASSIGNMENT USING CONTINUOUS ASSIGNMENT
	assign opcode = instr [6:0];
	assign func3 = instr [14:12];
	assign func7 = instr [31:25];
	
	//CONTROL SIGNAL GENERATOR
	always @ * begin
		case (opcode) 
			7'h33: begin
				BSel   = 0;
				WBSel  = 2'b01;
				RegWEn = 1;
				MemRW  = 0;
				PCSel  = 0;
				ASel   = 0;
				BrUn   = 0;
				ILoad  = 3'b000; 
			end
			7'h13: begin 
				BSel   = 1;
				WBSel  = 2'b01;
				RegWEn = 1;
				MemRW  = 0;
				PCSel  = 0;
				ASel   = 0;
				BrUn   = 0;
				ILoad  = 3'b000;
			end	
			7'h03: begin
				BSel = 1; 
				ILoad = func3;
				WBSel = 2'b00;
				RegWEn = 1;
				MemRW  = 0;
				PCSel  = 0;
				ASel   = 0;
				BrUn   = 0;
			end
			7'h23: begin
				BSel = 1; 
				ILoad = func3;
				WBSel = 2'b00;
				RegWEn = 0;
				MemRW  = 1;
				PCSel  = 0;
				ASel   = 0;
				BrUn   = 0;
			end
			7'h63: begin
				BSel   = 1;
				WBSel  = 2'b01;
				RegWEn = 0;
				MemRW  = 0;
				ASel   = 1;
				BrUn = func3[1] ? 1 : 0;
				case (func3)
					3'b000: PCSel = (BrEq) ? 1'b1 : 1'b0;
					3'b001: PCSel = (BrEq) ? 1'b0 : 1'b1;
					3'b100: PCSel = (BrLT) ? 1'b1 : 1'b0;
					3'b101: PCSel = (BrLT) ? 1'b0 : 1'b1;
					3'b110: PCSel = (BrLT) ? 1'b1 : 1'b0;
					3'b111: PCSel = (BrLT) ? 1'b0 : 1'b1;
					default: PCSel = 0;
				endcase
				ILoad = 3'b000;
			end
			7'h67: begin
				BSel   = 1;
				WBSel  = 2'b10;
				RegWEn = 1;
				MemRW  = 0;
				PCSel  = 1;
				ASel   = 1;
				BrUn   = 0;
				ILoad  = 3'b000;
			end
			7'h6F: begin
				BSel   = 1;
				WBSel  = 2'b10;
				RegWEn = 1;
				MemRW  = 0;
				PCSel  = 1;
				ASel   = 1;
				BrUn   = 0;
				ILoad  = 3'b000;
			end
			7'h37: begin
				BSel   = 0;
				WBSel  = 2'b11;
				RegWEn = 1;
				MemRW  = 0;
				PCSel  = 0;
				ASel   = 0;
				BrUn   = 0;
				ILoad  = 3'b000;
			end
			7'h17: begin
				BSel   = 1;
				WBSel  = 2'b01;
				RegWEn = 1;
				MemRW  = 0;
				PCSel  = 1;
				ASel   = 1;
				BrUn   = 0;
				ILoad  = 3'b000;
			end
			default: begin
				BSel   = 0;
				WBSel  = 2'b01;
				RegWEn = 1;
				MemRW  = 0;
				PCSel  = 0;
				ASel   = 0;
				BrUn   = 0;
				ILoad  = 3'b000;
			end
		endcase
	end
	always @ * begin
		case (opcode)
			7'h33: ALUSel = {func3,func7[5]};	
			7'h13: ALUSel = {func3,func7[5]};
			7'h03: ALUSel = 4'b0000;
			7'h23: ALUSel = 4'b0000;
			7'h63: ALUSel = 4'b0000;
			7'h17: ALUSel = 4'b0000;
			default: ALUSel = 4'b0000;
		endcase
	end
endmodule

