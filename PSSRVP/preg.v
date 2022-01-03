module preg #(parameter WIDTH = 5, AWIDTH = 32, DWIDTH = 32)(

	//GLOBAL INPUTS
	input clk, rst, 

	//INPUTS TO THE P-REG
	input [AWIDTH-1:0] pin,

	//OUTPUTS FROM THE P-REG
	output reg [DWIDTH-1:0] pout
);
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			pout <= 32'h0;
		end
		else begin
			pout <= pin;
		end
	end
endmodule
