module IMW #(parameter WIDTH = 5)(

	//GLOBAL INPUT
	input clk, rst,

	//INPUTS TO THE IDE
	input [1:0] WBSelM,
	input RegWEnM,

	//OUTPUTS FROM THE IDE
	output reg [1:0] WBSelW,
	output reg RegWEnW
	
);
	always @ (posedge clk) begin
		if (rst) begin
			WBSelW  <= 32'h0;
			RegWEnW <= 32'h0;
		end
		else begin
			WBSelW  <= WBSelM;
			RegWEnW <= RegWEnM;
		end
	end
endmodule