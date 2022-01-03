module bcomp #(parameter WIDTH = 5, AWIDTH = 32, DWIDTH = 32)(
	
	//INPUTS TO THE BRANCH-COMPARATOR
	input [DWIDTH-1:0] Data_A, Data_B,
	input BrUn,
	

	//OUTPUTS FROM THE BRANCH-COMPARATOR
	output BrEq, BrLT

);

	assign BrEq = (Data_A == Data_B) ? 1'b1 : 1'b0;
	assign BrLT = BrUn ? ((Data_A < Data_B) ? 1'b1 : 1'b0) : ($signed($signed(Data_A) < Data_B) ? 1'b1 : 1'b0);

endmodule
