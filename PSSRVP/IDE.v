module IDE #(parameter WIDTH = 5)(

	//GLOBAL INPUT
	input clk, rst,

	//INPUTS TO THE IDE
	input [3:0] ALUSel_D,
	input [1:0] BSel_D,
	input [2:0] ILoad_D,
	input [1:0] WBSel_D,
	input RegWEn_D,
	input MemRW_D,
	input PCSel_D,
	input [1:0] ASel_D,
	input BrUn_D,

	//OUTPUTS FROM THE IDE
	output reg [WIDTH-2:0] ALUSelE,
	output reg [1:0] BSelE,
	output reg [2:0] ILoadE,
	output reg [1:0] WBSelE,
	output reg RegWEnE,
	output reg MemRWE,
	output reg PCSelE,
	output reg [1:0] ASelE,
	output reg BrUnE
	
);
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			ALUSelE <= 32'h0;
			BSelE   <= 32'h0;
			ILoadE  <= 32'h0;
			WBSelE  <= 32'h0;
			RegWEnE <= 32'h0;
			MemRWE  <= 32'h0;
			PCSelE  <= 32'h0;
			ASelE   <= 32'h0;
			BrUnE   <= 32'h0;
		end
		else begin
			ALUSelE <= ALUSel_D;
			BSelE   <= BSel_D;
			ILoadE  <= ILoad_D;
			WBSelE  <= WBSel_D;
			RegWEnE <= RegWEn_D;
			MemRWE  <= MemRW_D;
			PCSelE  <= PCSel_D;
			ASelE   <= ASel_D;
			BrUnE   <= BrUn_D;
		end
	end
endmodule
