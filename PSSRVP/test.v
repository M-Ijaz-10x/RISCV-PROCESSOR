module test;
	//INPUTS DECLARATION
	reg clk;

	//TOP-LEVEL MODULE INSTANTIATION
	top_level inst_0 (
		.clk (clk)
	);
	
	//INITIAL BLOCK
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
		#1000 $finish;
	end
endmodule
