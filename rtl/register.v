module register #(parameter WIDTH =5, DWIDTH = 32)(

	//GLOBAL INPUTS
	input clk, RegWEn,

	//REGISTER FILE INPUTS
	input [DWIDTH-1:0] DataD,			//write back value
	input [WIDTH-1:0] AddrD,			//rd (Destination Register)
	input [WIDTH-1:0] AddrA,			//rs2 (Source Register 2)
	input [WIDTH-1:0] AddrB,			//rs1 (Source Register 1)
	
	//OUTPUTS FROM THE REGISTER
	output reg [DWIDTH-1:0] Data_A,
	output reg [DWIDTH-1:0] Data_B
);
	
	//MEMORY FOR READING AND WRITING
	reg [31:0] REG [31:0];
	initial begin
		REG[5'b00001] = 1;
		REG[5'b00010] = -2;
		REG[5'b00011] = -2;
		REG[5'b00100] = 4;
		REG[5'b00101] = 5;
		REG[5'b00110] = 6;
		REG[5'b00111] = 7;
		REG[5'b01000] = 8;
		REG[5'b01001] = 9;
		REG[5'b01010] = 10;
		REG[5'b01011] = 11;
	end
	always @ * begin
			REG [5'b00000] = 0;
			Data_A = REG [AddrA];
			Data_B = REG [AddrB];
	end
	always @ (posedge clk) begin
		if (RegWEn) begin
			REG [AddrD] = DataD;
		end
	end
endmodule
