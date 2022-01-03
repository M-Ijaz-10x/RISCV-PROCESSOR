module FCU #(parameter AWIDTH = 32)(
	//INPUTS TO THE FCU
	input [AWIDTH-1:0] Instr_D,
	input [AWIDTH-1:0] Instr_X,
	input [AWIDTH-1:0] Instr_M,
	input [AWIDTH-1:0] Instr_W,
	input [1:0] ASelE,
	input [1:0] BSelE,
	input RegWEnM,
	input RegWEnW,

	//OUTPUTS FROM THE FCU
	output reg [1:0] ASel_FCU,
	output reg [1:0] BSel_FCU,
	output reg [1:0] BHM
);
	always @ * begin
		if ((Instr_M[11:7] == Instr_X[19:15]) && (Instr_M[11:7] != 5'b0) && (RegWEnM)) begin
			ASel_FCU = 2'b10;
		end
		else if ((Instr_W[11:7] == Instr_X[19:15]) && (Instr_W[11:7] != 5'b0) && (RegWEnW)) begin
			ASel_FCU = 2'b11;	
		end
		else begin
			ASel_FCU = ASelE;
		end



		if ((Instr_M[11:7] == Instr_X[24:20]) && (Instr_M[11:7] != 5'b0) && (RegWEnM) && ~(Instr_X[6:0] == 32'h3)) begin
			if (Instr_X[6:0] == 32'h23) begin
				BSel_FCU = 2'b01;
				BHM = 2'b01;
			end
			else begin
				BSel_FCU = 2'b10;
				BHM = 2'b00;
			end
		end
		else if ((Instr_W[11:7] == Instr_X[24:20]) && (Instr_W[11:7] != 5'b0) && (RegWEnW) && ~(Instr_X[6:0] == 32'h3)) begin
			if (Instr_X[6:0] == 32'h23) begin
				BSel_FCU = 2'b01;
				BHM = 2'b10;
			end
			else begin
				BSel_FCU = 2'b11;
				BHM = 2'b00;
			end		
		end
		else begin
			BSel_FCU = BSelE;
		end
	end

endmodule
