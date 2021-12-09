// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module ALU_tb();
  reg clk = 1;
  reg rst = 0; // Disable reset for now
  
  parameter N = 5;
  reg[15:0] INST[N - 1: 0];
  reg[255:0] MEM_A[N - 1: 0];
  reg[255:0] MEM_B[N - 1: 0];
  reg[255:0] EXP_OUT[N - 1: 0];
  
  reg[15:0] curr_inst;
  reg[255:0] in_A;
  reg[255:0] in_B;
  reg[255:0] exp_OUT;
  wire[255:0] OUT;
  
  SIMD_ALU dut(
    .inst(curr_inst),
    .in_A(in_A),
    .in_B(in_B),
    .clk(clk),
    .rst(rst),
    
    .out(OUT)
  );
  
  // Testing support
  integer i = 0;
  wire passed = (OUT == exp_OUT);
  
  
  initial begin
    // Fill testing dataset and implement monitor
    // #1 NOP
    INST[0] = 0;
    MEM_A[0] = {256{1'b1}};
    MEM_B[0] = {128{2'b10}};
    EXP_OUT[0] = 0;
    
    // #2 PADD8
    INST[1] = 16'b0001_000_0_11001100;
    MEM_A[1] = {256{1'b1}};
    MEM_B[1] = {128{2'b10}};
    EXP_OUT[1] = {32{8'b10101001}};
    
    // #3 PADDI8
    INST[2] = 16'b0001_000_1_11001100;
    MEM_A[2] = {256{1'b1}};
    MEM_B[2] = {128{2'b10}};
    EXP_OUT[2] = {32{8'b11001011}};
    
    
    // #4 PADD64
    INST[3] = 16'b0001_011_0_11001100;
    MEM_A[3] = {256{1'b1}};
    MEM_B[3] = {128{2'b10}};
    EXP_OUT[3] = {4{{15{4'b1010}}, 4'b1001}};
    
    
    // #5 PADDI64
    INST[4] = 16'b0001_011_1_11001100;
    MEM_A[4] = {256{1'b1}};
    MEM_B[4] = {128{2'b10}};
    EXP_OUT[4] = {4{{56{1'b1}}, 8'b11001011}};
    
    // #6 PSUB8
    /*INST[5] = ;
    MEM_A[5] = ;
    MEM_B[5] = ;
    EXP_OUT[5] = ;
    
    // #7 PSUBI8
    INST[6] = ;
    MEM_A[6] = ;
    MEM_B[6] = ;
    EXP_OUT[6] = ;
    
    // #8 PSUB64
    INST[7] = ;
    MEM_A[7] = ;
    MEM_B[7] = ;
    EXP_OUT[7] = ;
    
    // #9 PSUBI64
    INST[8] = ;
    MEM_A[8] = ;
    MEM_B[8] = ;
    EXP_OUT[8] = ;
    
    // #10 
    INST[9] = ;
    MEM_A[9] = ;
    MEM_B[9] = ;
    EXP_OUT[9] = ;
    
    // #11
    INST[10] = ;
    MEM_A[10] = ;
    MEM_B[10] = ;
    EXP_OUT[10] = ;
    
    // #12
    INST[11] = ;
    MEM_A[11] = ;
    MEM_B[11] = ;
    EXP_OUT[11] = ;
    
    // #13
    INST[12] = ;
    MEM_A[12] = ;
    MEM_B[12] = ;
    EXP_OUT[12] = ;
    
    
    // #14
    INST[13] = ;
    MEM_A[13] = ;
    MEM_B[13] = ;
    EXP_OUT[13] = ;
    
    
    // #15
    INST[14] = ;
    MEM_A[14] = ;
    MEM_B[14] = ;
    EXP_OUT[14] = ;
    
    // #16
    INST[15] = ;
    MEM_A[15] = ;
    MEM_B[15] = ;
    EXP_OUT[15] = ;
    
    // #17
    INST[16] = ;
    MEM_A[16] = ;
    MEM_B[16] = ;
    EXP_OUT[16] = ;
    
    // #18
    INST[17] = ;
    MEM_A[17] = ;
    MEM_B[17] = ;
    EXP_OUT[17] = ;
    
    // #19
    INST[18] = ;
    MEM_A[18] = ;
    MEM_B[18] = ;
    EXP_OUT[18] = ;
    
    // #20
    INST[19] = ;
    MEM_A[19] = ;
    MEM_B[19] = ;
    EXP_OUT[19] = ;
    
    // #21
    INST[20] = ;
    MEM_A[20] = ;
    MEM_B[20] = ;
    EXP_OUT[20] = ;
    
    // #22
    INST[21] = ;
    MEM_A[21] = ;
    MEM_B[21] = ;
    EXP_OUT[21] = ;
    
    // #23
    INST[22] = ;
    MEM_A[22] = ;
    MEM_B[22] = ;
    EXP_OUT[22] = ;
    
    
    // #24
    INST[23] = ;
    MEM_A[23] = ;
    MEM_B[23] = ;
    EXP_OUT[23] = ;
    
    
    // #25
    INST[24] = ;
    MEM_A[24] = ;
    MEM_B[24] = ;
    EXP_OUT[24] = ;
    
    // #26
    INST[25] = ;
    MEM_A[25] = ;
    MEM_B[25] = ;
    EXP_OUT[25] = ;
    
    // #27
    INST[26] = ;
    MEM_A[26] = ;
    MEM_B[26] = ;
    EXP_OUT[26] = ;
    
    // #28
    INST[27] = ;
    MEM_A[27] = ;
    MEM_B[27] = ;
    EXP_OUT[27] = ;
    
    // #29
    INST[28] = ;
    MEM_A[28] = ;
    MEM_B[28] = ;
    EXP_OUT[28] = ;*/
    
    
    $monitor("time=%g\nA =%b\nB =%b\nO =%b\nEO=%b\n OPCODE=%b, DM=%b, IMMF=%b, IMM_REG=%b\nTest result: %b\n\n", $time, in_A, in_B, OUT, exp_OUT, curr_inst[15:12], curr_inst[11:9], curr_inst[8], curr_inst[7:0], passed);
  end
  
  
  
  always #500 clk <= ~clk;
  
  always @(posedge clk) begin
    // run tests
    if (i == N) begin
      $display("Last test is fictional.");
      $finish;
    end
      
    curr_inst <= INST[i];
    in_A <= MEM_A[i];
    in_B <= MEM_B[i];
    exp_OUT <= EXP_OUT[i];
    
    i = i + 1;
  end
endmodule