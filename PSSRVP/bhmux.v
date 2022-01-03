module bhmux #(parameter AWIDTH = 32)(

	//INPUTS TO THE HBMUX
	input [AWIDTH-1:0] alu_M,
	input [AWIDTH-1:0] wb,
	input [AWIDTH-1:0] Data_b,
	input [1:0] BHM,

	//OUTPUTS FROM THE HBMUX
	output reg [AWIDTH-1:0] RS2
);
	always @ * begin
		case (BHM)
			2'b00: RS2 = Data_b;
			2'b01: RS2 = alu_M;
			2'b10: RS2 = wb;
			2'b11: RS2 = 32'h0;
		endcase
	end
endmodule
