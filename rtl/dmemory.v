module dmemory #(parameter DWIDTH = 32, AWIDTH = 32, WIDTH = 5)(

	//GLOBAL SIGNALS
	input clk, rst, MemRW, 
	input [2:0] ILoad,

	//INPPUTS TO THE DMEM MODULE
	input [AWIDTH-1:0] Addr,
	input [DWIDTH-1:0] DataW,

	//OUTPUT FROM THE DMEM MODULE
	output reg [DWIDTH-1:0] DataR
);
	//MEMORY UNIT
	reg [DWIDTH-1:0] dmem [AWIDTH-1:0];

	//INITIAL
	initial begin
		//dmem [32'h00000006] = 32'b10010010_01001000_01100100_01111111;
		//dmem [32'h00000008] = 9;
		//dmem [32'h00000009] = 7;
		//dmem [32'h0000000A] = 7;
		//dmem [32'h0000000B] = 7;
		//dmem [32'h0000000C] = 7;
		//dmem [32'h0000000D] = 7;
		//dmem [32'h0000000E] = 7;
		//dmem [32'h0000000F] = 7;
		//dmem [32'h7FFFFFF0] = 7;
	end

	//ASYNCHRONOUS READ
	always @* begin
		case (ILoad)
			3'b000: begin
				DataR [7:0]   = dmem [Addr];
				DataR [15:8]  = {8{DataR[7]}};
				DataR [23:16] = {8{DataR[7]}};
				DataR [31:24] = {8{DataR[7]}};
			end
			3'b001: begin
				DataR [15:0]   = dmem [Addr];
				DataR [23:16] = {8{DataR[15]}};
				DataR [31:24] = {8{DataR[15]}};
			end
			3'b010: DataR = dmem [Addr];
			3'b100: begin
				DataR [7:0]   = dmem [Addr];
				DataR [15:8]  = {8{1'b0}};
				DataR [23:16] = {8{1'b0}};
				DataR [31:24] = {8{1'b0}};
			end
			3'b101: begin
				DataR [15:0]   = dmem [Addr];
				DataR [23:16] = {8{1'b0}};
				DataR [31:24] = {8{1'b0}};
			end
			default: DataR[31:0] = 32'h0;
		endcase 
	end

	//SYNCHRONOUS WRITE
	always @ (posedge clk) begin
		if (MemRW) begin
			case (ILoad)
				3'b000: dmem [Addr] = {{24{DataW[7]}}, DataW [7:0]};
				3'b001: dmem [Addr] = {{16{DataW[15]}}, DataW [15:0]};
				3'b010: dmem [Addr] = DataW;
				default: dmem[Addr] = 32'h0;
			endcase
		end
	end
endmodule
