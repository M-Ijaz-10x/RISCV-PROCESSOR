module IDE #(parameter WIDTH = 5)(

	//GLOBAL INPUT
	input clk, rst,

	//INPUTS TO THE IDE
	input [3:0] ALUSel,
	input [1:0] BSel,
	input [2:0] ILoad,
	input [1:0] WBSel,
	input RegWEn,
	input MemRW,
	input PCSel,
	input [1:0] ASel,
	input BrUn,

	//OUTPUTS FROM THE IDE
	output reg [WIDTH-1:0] ALUSelE,
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
			ALUSelE <= ALUSel;
			BSelE   <= BSel;
			ILoadE  <= ILoad;
			WBSelE  <= WBSel;
			RegWEnE <= RegWEn;
			MemRWE  <= MemRW;
			PCSelE  <= PCSel;
			ASelE   <= ASel;
			BrUnE   <= BrUn;
		end
	end
endmodule
