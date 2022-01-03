module wbmux #(parameter WIDTH = 5, AWIDTH = 32, DWIDTH = 32)(
	
	//INPUTS TO THE MUX
	input [DWIDTH-1:0] DataR,
	input [AWIDTH-1:0] alu_out,
	input [1:0] WBSel,
	input [AWIDTH-1:0] pc_updated,
	input [DWIDTH-1:0] imm,  

	//OUTPUTS FROM THE MUX
	output reg [DWIDTH-1:0] wb

);
	always @ * begin
		case (WBSel)
			2'b00: wb = DataR;
			2'b01: wb = alu_out;
			2'b10: wb = pc_updated;
			2'b11: wb = imm;
		endcase
	end
endmodule 
