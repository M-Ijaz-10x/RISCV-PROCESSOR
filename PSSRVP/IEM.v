module IEM #(parameter WIDTH = 5)(

	//GLOBAL INPUT
	input clk, rst,

	//INPUTS TO THE IDE
	input [2:0] ILoadE,
	input [1:0] WBSelE,
	input RegWEnE,
	input MemRWE,

	//OUTPUTS FROM THE IDE
	output reg [2:0] ILoadM,
	output reg [1:0] WBSelM,
	output reg RegWEnM,
	output reg MemRWM
	
);
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			ILoadM  <= 32'h0;
			WBSelM  <= 32'h0;
			RegWEnM <= 32'h0;
			MemRWM  <= 32'h0;
		end
		else begin
			ILoadM  <= ILoadE;
			WBSelM  <= WBSelE;
			RegWEnM <= RegWEnE;
			MemRWM  <= MemRWE;
		end
	end
endmodule
