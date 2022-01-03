module preg #(parameter WIDTH = 5, AWIDTH = 32, DWIDTH = 32)(

	//GLOBAL INPUTS
	input clk, rst,
	input PC_H, ID_H,
	//INPUTS TO THE P-REG
	input [AWIDTH-1:0] pin,

	//OUTPUTS FROM THE P-REG
	output reg [DWIDTH-1:0] pout
);
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			pout <= 32'h0;
		end
		else if (PC_H && ID_H) begin
			pout <= pout;
		end
		else begin
			pout <= pin;
		end
	end
endmodule
