module amux #(parameter WIDTH = 5, AWIDTH = 32, DWIDTH = 32)(

	//INPUTS TO THE AMUX
	input [AWIDTH-1:0] pc,
	input [DWIDTH-1:0] Data_A,
	input ASel,

	//OUTPUTS FROM AMUX
	output [DWIDTH-1:0] aout
);

	assign aout = ASel ? pc : Data_A;

endmodule
