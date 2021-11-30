module imemory #(parameter WIDTH = 8, AWIDTH = 32, DWIDTH = 32)(
	//INPUTS TO THE IMEM
	input [AWIDTH-1:0] pc,

	//OUTPUT FROM IMEM
	output wire [DWIDTH-1:0] instr
);
	//MEMORY UNIT
	reg [7:0] imem [(2**26)-1:0];
	initial begin
		//R-TYPE
		{imem[3],imem[2],imem[1],imem[0]}        =	 32'h0041e5b3; //or x11 x3 x4 => x3=3, x4=4, x11=7
		{imem[7],imem[6],imem[5],imem[4]}        =	 32'h00208433; //add x8 x1 x2 => x1=1, x2=2, x8=3
		{imem[11],imem[10],imem[9],imem[8]}      =	 32'h00317533; //and x10 x2 x3 => x2=2, x3=3, x10=2
		{imem[15],imem[14],imem[13],imem[12]}    =	 32'h404404b3; //sub x9 x8 x4 => x8=3, x4=4, x9=-1
		{imem[19],imem[18],imem[17],imem[16]}    =	 32'h00414433; //xor x8 x2 x4 => x2=2, x4=4, x8=6
		{imem[23],imem[22],imem[21],imem[20]}    =	 32'h00412433; //slt x8 x2 x4 => x2=2, x4=4, x8=0
		{imem[27],imem[26],imem[25],imem[24]}    =	 32'h00413433; //sltu x8 x2 x4 => x2=2, x4=4, x8=1
		{imem[31],imem[30],imem[29],imem[28]}    =	 32'h00411433; //sll x8 x2 x4 => x2=2, x4=4, x8=32
		{imem[35],imem[34],imem[33],imem[32]}    =	 32'h00235833; //srl x16 x6 x2 => x6=6, x2=2, x16=1
		{imem[39],imem[38],imem[37],imem[36]}    =	 32'h401158b3; //sra x17 x2 x1 => x2=2, x1=1, x17=1

		//I-TYPE
		{imem[43],imem[42],imem[41],imem[40]}    =	 32'h00120093; //addi x1 x4 1 => x4=4, x1=1+4=5
		{imem[47],imem[46],imem[45],imem[44]}    =	 32'h0021A093; //slti x1 x3 2 => x3=3, x1=0
		{imem[51],imem[50],imem[49],imem[48]}    =	 32'h00223093; //sltiu x1 x4 2 => x4=4, x1=0
		{imem[55],imem[54],imem[53],imem[52]}    =	 32'h0031C093; //xori x1 x3 3 => x3=3, x1=0
		{imem[59],imem[58],imem[57],imem[56]}    =	 32'h0041E093; //ori x1 x3 4 => x3=3, x1=7
		{imem[63],imem[62],imem[61],imem[60]}    =	 32'h00417093; //andi x1 x2 4 => x2=2, x1=0

		//I-TYPE-5-BIT-IMMEDIATE
		{imem[67],imem[66],imem[65],imem[64]}    =	 32'h00211413; //slli x8 x2 2 => x2=2, x1=8
		{imem[71],imem[70],imem[69],imem[68]}    =	 32'h00215413; //srli x8 x2 2 => x2=2, x8=0
		{imem[75],imem[74],imem[73],imem[72]}    =	 32'h40215413; //srai x8 x2 2 => x2=2, x8=0
		
		//LOAD-I-TYPE
		{imem[79],imem[78],imem[77],imem[76]}    =	 32'h00410083; //lb x1 4(x2) => x1=00000000_00000000_00000000_01111111
		{imem[83],imem[82],imem[81],imem[80]}    =	 32'h00411083; //lh x1 4(x2) => x1=00000000_00000000_01100100_01111111
		{imem[87],imem[86],imem[85],imem[84]}    =	 32'h00412083; //lw x1 4(x2) => x1=10010010_01001000_01100100_01111111
		{imem[91],imem[90],imem[89],imem[88]}    =	 32'h00414083; //lbu x1 4(x2) => x1=00000000_00000000_00000000_01111111
		{imem[95],imem[94],imem[93],imem[92]}    =	 32'h00415083; //lhu x1 4(x2) => x1=00000000_00000000_01100100_01111111

		//S-TYPE
		{imem[99],imem[98],imem[97],imem[96]}            =	 32'h00310223; //sb x3 4(x2) => x2=3 (With offset of 4)
		{imem[103],imem[102],imem[101],imem[100]}        =	 32'h00311223; //sh x3 4(x2) => x2=3 (With offset of 4)
		{imem[107],imem[106],imem[105],imem[104]}        =	 32'h00312223; //sw x3 4(x2) => x2=3 (With offset of 4)

		//B-TYPE
		{imem[111],imem[110],imem[109],imem[108]}        =	 32'h00218863; //beq x3 x2 label => if brach is taken the pc is updated to pc+immediate
		{imem[115],imem[114],imem[113],imem[112]}        =	 32'h00219863; //bne x3 x2 label => if brach is taken the pc is updated to pc+immediate
		{imem[119],imem[118],imem[117],imem[116]}        =	 32'h0021C863; //blt x3 x2 label => if brach is taken the pc is updated to pc+immediate
		{imem[123],imem[122],imem[121],imem[120]}        =	 32'h0021D863; //bge x3 x2 label => if brach is taken the pc is updated to pc+immediate
		{imem[127],imem[126],imem[125],imem[124]}        =	 32'h0021E863; //bltu x3 x2 label => if brach is taken the pc is updated to pc+immediate
		{imem[131],imem[130],imem[129],imem[128]}        =	 32'h0021F863; //bgeu x3 x2 label => if brach is taken the pc is updated to pc+immediate

		//JUMPING-I-TYPE
		{imem[135],imem[134],imem[133],imem[132]}        =	 32'h028101E7; //jalr x3 x2 40 => pc=Reg[x3]+40, rd(x2)=pc+4

		//J-TYPE
		{imem[139],imem[138],imem[137],imem[136]}        =	 32'h04C000EF; //jal x3 4 => x3=pc+4, jump tp label (76 in this case)

		//U-TYPE
		{imem[143],imem[142],imem[141],imem[140]} 	 = 	 32'h1E2401B7; //lui x3 123456 => x3=123456
		{imem[147],imem[146],imem[145],imem[144]}        =	 32'h6F7E3197; //auipc x3 456675 => x3=456675
		
	end
	assign instr = {imem[pc+3],imem[pc+2],imem[pc+1],imem[pc+0]};
endmodule
