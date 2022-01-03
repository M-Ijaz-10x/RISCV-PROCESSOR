module hmux #(parameter AWIDTH = 32)(
	//INPUTS TO THE HMUX
	input [AWIDTH-1:0] Instr_D,
	input [AWIDTH-1:0] nop,
	input ID_H,

	//OUTPUTS FROM THE HMUX
	output [AWIDTH-1:0] Instr_H
);
	assign Instr_H = ID_H ? nop : Instr_D;
endmodule
