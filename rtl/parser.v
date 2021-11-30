module parser #(parameter WIDTH =5, AWIDTH = 32, DWIDTH = 32)(

	//INPUTS TO THE PARSER
	input [DWIDTH-1:0] instr,

	//OUTPUTS FROM THE PARSER
	output [WIDTH-1:0] inst0,
	output [WIDTH-1:0] inst1,
	output [WIDTH-1:0] inst2
);

	assign inst0 = instr[11:7];
	assign inst1 = instr[19:15];
	assign inst2 = instr[24:20];

endmodule
