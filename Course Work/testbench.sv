// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module ALU_tb();
  reg clk = 0;
  reg rst = 0; // Disable reset for now
  
  parameter N = 29;
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
    // dump waves
    $dumpfile("dump.vcd");
    $dumpvars(1, ALU_tb);
    
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
    // DONE
    
    // #6 PSUB8
    INST[5] = 16'b0010_000_0_11001100;
    MEM_A[5] = {256{1'b1}};
    MEM_B[5] = {128{2'b10}};
    EXP_OUT[5] = {128{2'b01}};
    
    // #7 PSUBI8
    INST[6] = 16'b0010_000_1_11001100;
    MEM_A[6] = {256{1'b1}};
    MEM_B[6] = {128{2'b10}};
    EXP_OUT[6] = {64{4'b0011}};
    
    // #8 PSUB64
    INST[7] = 16'b0010_011_0_11001100;
    MEM_A[7] = {256{1'b1}};
    MEM_B[7] = {128{2'b10}};
    EXP_OUT[7] = {128{2'b01}};
    
    // #9 PSUBI64
    INST[8] = 16'b0010_011_1_11001100;
    MEM_A[8] = {256{1'b1}};
    MEM_B[8] = {128{2'b10}};
    EXP_OUT[8] = {4{ {56{1'b0}},8'b00110011}}; 
    // DONE
    
    
    
    // #10 PSLL8
    INST[9] = 16'b0011_000_0_11001100;
    MEM_A[9] = {256{1'b1}};
    MEM_B[9] = {128{2'b10}};
    EXP_OUT[9] = {32{8'b11111100}};
    
    // #11 PSLLI8
    INST[10] = 16'b0011_000_1_11001100;
    MEM_A[10] = {256{1'b1}};
    MEM_B[10] = {128{2'b10}};
    EXP_OUT[10] = {32{8'b11110000}};
    
    // #12 PSLL64
    INST[11] = 16'b0011_011_0_11001100;
    MEM_A[11] = {256{1'b1}};
    MEM_B[11] = {128{2'b10}};
    EXP_OUT[11] = { 4{ {22{1'b1}}, {42{1'b0}} } };
    
    // #13 PSLLI64
    INST[12] = 16'b0011_011_1_11001100;
    MEM_A[12] = {256{1'b1}};
    MEM_B[12] = {128{2'b10}};
    EXP_OUT[12] = { 4{ {52{1'b1}}, {12{1'b0}} } }; 
    
    
    // #14 PSRL8
    INST[13] = 16'b0100_000_0_11001100;
    MEM_A[13] = {256{1'b1}};
    MEM_B[13] = {128{2'b10}};
    EXP_OUT[13] = {32{8'b00111111}};
    
    
    // #15 PSRLI8
    INST[14] = 16'b0100_000_1_11001100;
    MEM_A[14] = {256{1'b1}};
    MEM_B[14] = {128{2'b10}};
    EXP_OUT[14] = {32{8'b00001111}};
    
    // #16 PSRL64
    INST[15] = 16'b0100_011_0_11001100;
    MEM_A[15] = {256{1'b1}};
    MEM_B[15] = {128{2'b10}};
    EXP_OUT[15] = { 4{ {42{1'b0}}, {22{1'b1}} } };
    
    // #17 PSRLI64
    INST[16] = 16'b0100_011_1_11001100;
    MEM_A[16] = {256{1'b1}};
    MEM_B[16] = {128{2'b10}};
    EXP_OUT[16] = { 4{ {12{1'b0}}, {52{1'b1}} } };
    
    // #18 PSRA8
    INST[17] = 16'b0101_000_0_11001100;
    MEM_A[17] = {32{8'b10000000}};
    MEM_B[17] = {128{2'b10}};
    EXP_OUT[17] = {32{8'b11100000}};
    
    // #19 PSRAI8
    INST[18] = 16'b0101_000_1_11001100;
    MEM_A[18] = {32{8'b10000000}};
    MEM_B[18] = {128{2'b10}};
    EXP_OUT[18] = {32{8'b11111000}};
    
    // #20 PSRA64
    INST[19] = 16'b0101_011_0_11001100;
    MEM_A[19] = {32{8'b10000000}};
    MEM_B[19] = {128{2'b10}};
    EXP_OUT[19] = {4{ {40{1'b1}}, 8'b11100000, {2{8'b00100000}} }};
    
    // #21 PSRAI64
    INST[20] = 16'b0101_011_1_11001100;
    MEM_A[20] = {32{8'b10000000}};
    MEM_B[20] = {128{2'b10}};
    EXP_OUT[20] = {4{ {3{4'b1111}}, {6{8'b10000000}}, 4'b1000}};
    // DONE
    
    
    // #22 PCMPEQ8
    INST[21] = 16'b0110_000_1_11001100;
    MEM_A[21] = {32{8'b10010011}};
    MEM_B[21] = { {16{8'b10000000}}, {16{8'b10010011}} };
    EXP_OUT[21] = { {16{8'b00000000}}, {16{8'b11111111}} };
    
    // #23 PCMPEQ64
    INST[22] = 16'b0110_011_1_11001100;
    MEM_A[22] = {32{8'b10010011}};
    MEM_B[22] = { {16{8'b10000000}}, {16{8'b10010011}} };
    EXP_OUT[22] = { {16{8'b00000000}}, {16{8'b11111111}} };
    
    
    // #24 PCMPGT8
    INST[23] = 16'b0111_000_1_11001100;
    MEM_A[23] = {32{8'b01010011}};
    MEM_B[23] = { {16{8'b11010011}}, {16{8'b01010111}} };
    EXP_OUT[23] = { {16{8'b11111111}}, {16{8'b00000000}} };
    
    
    // #25 PCMPGT64 
    INST[24] = 16'b0111_011_1_11001100;
    MEM_A[24] = {32{8'b01010011}};
    MEM_B[24] = { {16{8'b11010011}}, {16{8'b01010111}} };
    EXP_OUT[24] = { {16{8'b11111111}}, {16{8'b00000000}} };
    // DONE
    
    
    
    // #26 UNPKGLO8
    INST[25] = 16'b1000_000_1_11001100;
    MEM_A[25] = {32{8'b01010011}};
    MEM_B[25] = { {16{8'b11010011}}, {16{8'b01011111}} };
    EXP_OUT[25] = {16{16'b01010011_01011111}};
    
    // #27 UNPKGLO64
    INST[26] = 16'b1000_011_1_11001100;
    MEM_A[26] = {32{8'b01010011}};
    MEM_B[26] = { {16{8'b11010011}}, {16{8'b01011111}} };
    EXP_OUT[26] = {2{ {8{8'b01010011}}, {8{8'b01011111}} }};
    
    // #28 UNPKGHI8
    INST[27] = 16'b1001_000_1_11001100;
    MEM_A[27] = {32{8'b01010011}};
    MEM_B[27] = { {16{8'b11010011}}, {16{8'b01010111}} };
    EXP_OUT[27] = {16{16'b01010011_11010011}};
    
    // #29 UNPKGHI64
    INST[28] = 16'b1001_011_1_11001100;
    MEM_A[28] = {32{8'b01010011}};
    MEM_B[28] = { {16{8'b11010011}}, {16{8'b01010111}} };
    EXP_OUT[28] = {2{ {8{8'b01010011}}, {8{8'b11010011}} }};
    // DONE
  end
  
  
  
  always #500 clk <= ~clk;
  
  // On negedge we write the data in
  always @(negedge clk) begin
    // run tests
    if (i == N) begin
      #1
      $finish;
    end
      
    curr_inst <= INST[i];
    in_A <= MEM_A[i];
    in_B <= MEM_B[i];
    exp_OUT <= EXP_OUT[i];
    
    i <= i + 1;
  end
  
  // On posedge the ALU execution starts, so we wait a bit to synchronize
  // the output for tests
  always @(posedge clk) begin
    #1
    $display("Test no.%d\ntime=%g\nA =%b\nB =%b\nO =%b\nEO=%b\n OPCODE=%b, DM=%b, IMMF=%b, IMM_REG=%b\nTest result: %b\n", i, $time, in_A, in_B, OUT, exp_OUT, curr_inst[15:12], curr_inst[11:9], curr_inst[8], curr_inst[7:0], passed);
  end
endmodule