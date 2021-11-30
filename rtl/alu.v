module alu #(parameter DWIDTH=32) (
input [3:0] ALUSel,
input [DWIDTH-1:0] rs1, rs2,
output reg [DWIDTH-1:0] alu_out
);

always@(*) begin
	case (ALUSel)
		4'b0000: alu_out = rs1 + rs2;
		4'b0001: alu_out = rs1 - rs2;
		4'b0010: alu_out = rs1 << rs2;
		4'b0100: alu_out = $signed($signed(rs1) < rs1);
		4'b0110: alu_out = rs1 < rs2;
		4'b1000: alu_out = rs1 ^ rs2;
		4'b1010: alu_out = rs1 >> rs2;
		4'b1011: alu_out = $signed($signed(rs1) >>> rs2);
		4'b1100: alu_out = rs1 | rs2;
		4'b1110: alu_out = rs1 & rs2;
		default: alu_out = 32'h0;
	endcase
end
endmodule
