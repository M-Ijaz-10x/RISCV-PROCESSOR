module bmux #(parameter WIDTH = 5, AWIDTH = 32, DWIDTH = 32)(
	
	//INPUTS TO THE MUX
	input [DWIDTH-1:0] rs2,
	input [AWIDTH-1:0] imm,
	input BSel, 

	//OUTPUTS FROM THE MUX
	output [DWIDTH-1:0] rs_2

);
	assign rs_2 = BSel ? imm : rs2;
endmodule 
