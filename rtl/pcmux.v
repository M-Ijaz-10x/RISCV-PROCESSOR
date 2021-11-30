module pcmux #(parameter WIDTH = 5, AWIDTH = 32, DWIDTH = 32)(

	//INPUTS TO THE PCMUX
	input [AWIDTH-1:0] pc_updated,
	input [DWIDTH-1:0] alu_out,
	input PCSel,

	//OUTPUTS FROM THE PCMUX
	output [DWIDTH-1:0] in
);

	assign in = PCSel ? alu_out : pc_updated; 

endmodule
