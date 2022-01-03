module HDU #(parameter WIDTH = 5, AWIDTH = 32, DWIDTH = 32)(
	//INPUTS TO THE HDU
	input [AWIDTH-1:0] Instr_D,
	input [AWIDTH-1:0] Instr_X,
	input MemRWE,

	//OUTPUTS FROM THE HDU
	output reg [1:0] ASel_FCU,
	output reg [1:0] BSel_FCU
);

endmodule
