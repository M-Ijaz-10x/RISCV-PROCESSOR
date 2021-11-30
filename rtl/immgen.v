module immgen #(parameter AWIDTH = 32, DWIDTH = 32)(
	input [AWIDTH-1:0] instr,
	output reg [DWIDTH-1:0] imm
);
	wire [6:0] opcode;
	assign opcode = instr [6:0];
	wire [3:0] func3;
	assign func3 = instr [14:12];
	always @(*) begin
		case(opcode)
			7'b0000011 : imm <= {{20{instr[31]}},instr[31:20]};// I-Load-type
			7'b0010111 : imm <= {{12{instr[31]}},instr[31:12]}; //U-TYPE INSTRUCTION
			7'b0100011 : imm <= {{20{instr[31]}},instr[31:25],instr[11:7]};
			7'b0110111 : imm <= {{12{instr[31]}},instr[31:12]}; //U-TYPE INSTRUCTION
			7'b1100011 : imm <= {{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0};
			7'b0010011 : // I-TYPE (12-BIT IMMEDIATE, 5-BIT IMMEDIATE)
					case (func3)
						3'b000: imm <= {{20{instr[31]}},instr[31:20]};
						3'b001: imm <= {{27{instr[24]}},instr[24:20]}; //5-BIT IMMEDIATE						
						3'b010: imm <= {{20{instr[31]}},instr[31:20]};
						3'b011: imm <= {{20{1'b0}},instr[31:20]};
						3'b100: imm <= {{20{instr[31]}},instr[31:20]};
						3'b101: imm <= {{27{instr[24]}},instr[24:20]}; //5-BIT IMMEDIATE
						3'b110: imm <= {{20{instr[31]}},instr[31:20]};
						3'b111: imm <= {{20{instr[31]}},instr[31:20]};
					endcase
			7'b1100111 : imm <= {{20{instr[31]}},instr[31:20]};// I-TYPE
			7'b1101111 : imm <= {{11{instr[31]}},instr[31],instr[19:12],instr[20],instr[30:21],1'b0};
		default : imm <= 32'h0;
		endcase
	end
endmodule
