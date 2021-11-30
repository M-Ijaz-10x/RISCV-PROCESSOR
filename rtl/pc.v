module pc #(parameter AWIDTH =32, DWIDTH = 32)(

	//GLOBAL INPUTS
	input clk,

	//INPUTS TO THE PROGRAM COUNTER
	input [DWIDTH-1:0] in,

	//OUTPUTS FROM THE PROGRAM COUNTER
	output reg [DWIDTH-1:0] out,
	output [AWIDTH-1:0] pc_updated 
);
	initial begin
		out = 0;
	end

	always @ (posedge clk) begin
		out <= in;
	end

	assign pc_updated = out + 4;

endmodule
