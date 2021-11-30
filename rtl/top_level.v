module top_level
(
  input  wire clk
);

  localparam integer AWIDTH=32, DWIDTH=32, WIDTH = 5;

  /////////////////////
  // PROGRAM COUNTER //
  /////////////////////

  wire [31:0] pc_updated;
  wire [31:0] out;
  wire [3:0] ALUSel;
  wire [31:0] instr;
  wire [31:0] Data_A;
  wire [31:0] Data_B;
  wire [31:0] imm;
  wire BSel;
  wire [31:0] rs_2;
  wire [2:0] ILoad;
  wire [31:0] DataR;
  wire [1:0] WBSel;
  wire [31:0] wb;
  wire RegWEn;
  wire MemRW;
  wire [31:0] in;
  wire PCSel;
  wire [31:0] aout;
  wire ASel;
  wire BrUn;
  wire BrEq;
  wire BrLT;

  pc
  #(
    .AWIDTH ( AWIDTH ),
    .DWIDTH ( DWIDTH ) 
   )
    program_counter
   (
    .clk     ( clk   ),
    .in      ( in    ),
    .out     ( out   ),
    .pc_updated (pc_updated)
   ) ;


  ////////////////
  /////IMEM //////
  ////////////////

  

  imemory 
  #(.AWIDTH (AWIDTH),
    .DWIDTH (DWIDTH))
  imem_inst
  (
    .pc (out),
    .instr (instr)
  ) ;


  /////////////////////
  /// REGISTER FILE ///
  /////////////////////

  wire [4:0] inst0;
  wire [4:0] inst1;
  wire [4:0] inst2;
  wire [31:0] alu_out;

  register
  #(
    .WIDTH   ( WIDTH  ),
    .DWIDTH  ( DWIDTH ) 
   )
    register_inst
   (
    .clk     ( clk     ),
    .RegWEn  ( RegWEn  ),
    .DataD    ( wb  ),
    .AddrD    ( inst0  ),
    .AddrA  ( inst1 ),
    .AddrB ( inst2 ), 
    .Data_A (Data_A),
    .Data_B (Data_B)
   ) ;


  /////////////////////
  ////// CONTROL //////
  /////////////////////

  control
  #(
    .WIDTH   ( WIDTH  ),
    .AWIDTH   ( AWIDTH  ),
    .DWIDTH   ( DWIDTH  ) 
   )
    control_inst
   (
    .instr     (instr),
    .ALUSel    (ALUSel),
    .BSel      (BSel),
    .ILoad     (ILoad),
    .WBSel     (WBSel),
    .RegWEn    (RegWEn),
    .MemRW     (MemRW),
    .PCSel     (PCSel),
    .ASel      (ASel),
    .BrUn      (BrUn),
    .BrEq      (BrEq ),
    .BrLT      (BrLT )
   ) ;


  /////////////////////////
  ////////// ALU///////////
  /////////////////////////

  alu
  #(
    .DWIDTH ( DWIDTH ) 
   )
    alu_inst
   (
    .ALUSel    ( ALUSel    ),
    .rs1     ( aout     ),
    .rs2     ( rs_2    ),
    .alu_out   ( alu_out   )
   ) ;


  //////////////////////////
  ///////// PARSER /////////
  //////////////////////////

  parser
  #(
    .WIDTH    ( DWIDTH ) 
   )
    parser_inst
   (
    .instr      ( instr    ),
    .inst0      ( inst0    ),
    .inst1      ( inst1    ),
    .inst2      ( inst2    )
   ) ;



  //////////////////////////
  ////////// BMUX //////////
  //////////////////////////

  bmux
  #(
    .WIDTH    ( WIDTH ),
    .AWIDTH    ( AWIDTH ),
    .DWIDTH    ( DWIDTH ) 
   )
    bmux_inst
   (
    .rs2      ( Data_B ),
    .imm      ( imm    ),
    .BSel     ( BSel   ),
    .rs_2     ( rs_2   )
   ) ;



  //////////////////////////
  ///////// IMMGEN /////////
  //////////////////////////

  immgen
  #(
    .AWIDTH    ( AWIDTH ),
    .DWIDTH    ( DWIDTH ) 
   )
    immgen_inst
   (
    .instr    ( instr  ),
    .imm      ( imm    )
   ) ;



  //////////////////////////
  ////////// DMEM //////////
  //////////////////////////

  dmemory
  #(
    .AWIDTH    ( AWIDTH ),
    .DWIDTH    ( DWIDTH ),
    .WIDTH     (  WIDTH )
   )
    dmemory_inst
   (
    .clk    ( clk  ),
    .rst    ( rst  ),
    .ILoad  ( ILoad),
    .MemRW  ( MemRW),
    .Addr   ( alu_out ),
    .DataW  (Data_B),
    .DataR  (DataR)
   ) ;



  ///////////////////////////
  ////////// WBMUX //////////
  ///////////////////////////

  wbmux
  #(
    .AWIDTH    ( AWIDTH ),
    .DWIDTH    ( DWIDTH ),
    .WIDTH     (  WIDTH )
   )
    wbmux_inst
   (
    .DataR    ( DataR  ),
    .alu_out    ( alu_out  ),
    .WBSel  ( WBSel),
    .wb  ( wb),
    .pc_updated (pc_updated),
    .imm (imm)
   ) ;



  ///////////////////////////
  ////////// PCMUX //////////
  ///////////////////////////

  pcmux
  #(
    .AWIDTH    ( AWIDTH ),
    .DWIDTH    ( DWIDTH ),
    .WIDTH     (  WIDTH )
   )
    pcmux_inst
   (
    .pc_updated    ( pc_updated  ),
    .alu_out    ( alu_out  ),
    .PCSel  ( PCSel),
    .in  ( in)
   ) ;



  ///////////////////////////
  /////////// AMUX //////////
  ///////////////////////////

  amux
  #(
    .AWIDTH    ( AWIDTH ),
    .DWIDTH    ( DWIDTH ),
    .WIDTH     (  WIDTH )
   )
    amux_inst
   (
    .pc    ( out  ),
    .Data_A    ( Data_A  ),
    .ASel  ( ASel),
    .aout  ( aout)
   ) ;



  ///////////////////////////
  ////////// BCOMP //////////
  ///////////////////////////

  bcomp
  #(
    .AWIDTH    ( AWIDTH ),
    .DWIDTH    ( DWIDTH ),
    .WIDTH     (  WIDTH )
   )
    bcomp_inst
   (
    .Data_A    ( Data_A  ),
    .Data_B    ( Data_B  ),
    .BrUn  ( BrUn),
    .BrEq  ( BrEq),
    .BrLT  ( BrLT)
   ) ;
endmodule