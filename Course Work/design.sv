`include "adder.v"
`include "shifter.v"
`include "comparator.v"
`include "packer.v"
`include "decoder.v"

`timescale 1ns/1ps

module SIMD_ALU(
  input wire[15:0] inst,
  input wire[255:0] in_A,
  input wire[255:0] in_B,
  input wire clk,
  input wire rst,
  
  output wire[255:0] out
);
  parameter NOP  	= 4'b0000;
  parameter PADD 	= 4'b0001;
  parameter PSUB 	= 4'b0010;
  parameter PSLL 	= 4'b0011;
  parameter PSRL 	= 4'b0100;
  parameter PSRA 	= 4'b0101;
  parameter PCMPEQ 	= 4'b0110;
  parameter PCMPGT 	= 4'b0111;
  parameter PUNPKGLO= 4'b1000;
  parameter PUNPKGHI= 4'b1001;
  
  
  // Decoding instruction
  wire[3:0] opcode;
  wire[2:0] data_mode;
  wire imm_flag;
  wire[7:0] imm;
  simd_decoder decoder(
    .inst(inst),
    
    .opcode(opcode),
    .data_mode(data_mode),
    .imm_flag(imm_flag),
    .imm(imm)
  );
  
  
  // Flags for submodules
  wire sub_flag = ~opcode[0];
  wire[1:0] shift_sel = opcode[1:0];
  wire gt_flag = opcode[0];
  wire hi_flag = opcode[0];
  
  
  // Inner registers
  reg[255:0] A_reg;
  reg[255:0] B_reg;
  
  // Outputs from modules
  wire[255:0] adder_res;
  wire[255:0] shifter_res;
  wire[255:0] comparator_res;
  wire[255:0] packer_res;
  
  // General output
  reg[255:0] res;
  assign out = res;
  
  
  // Instantiating ALU submodules
  simd_adder adder(
    .A(in_A),
    .B(in_B),
    .data_mode(data_mode),
    .sub_flag(sub_flag),
    .imm_flag(imm_flag),
    .imm_reg(imm),
    
    .out(adder_res)
  );
  simd_shifter shifter(
  	.A(in_A),
    .B(in_B),
    .data_mode(data_mode),
    .sel(shift_sel),
    .imm_flag(imm_flag),
    .imm_reg(imm),
    
    .out(shifter_res)
  );
  simd_comparator comparator(
    .A(in_A),
    .B(in_B),
    .data_mode(data_mode),
    .gt_flag(gt_flag),
    
    .out(comparator_res)
  );
  simd_packer packer(
  	.A(in_A),
    .B(in_B),
    .data_mode(data_mode),
    .hi_flag(hi_flag),
    
    .out(packer_res)
  );
  
  
  
  always @(posedge clk) begin
    if (rst) begin
      // perform NOP and reset Registers
      A_reg <= 0;
      B_reg <= 0;
      res <= 0;
    end else begin
      A_reg <= in_A;
      B_reg <= in_B;
      case(opcode)
        PADD, PSUB: res <= adder_res;
        PSLL, PSRL, PSRA: res <= shifter_res;
        PCMPEQ, PCMPGT: res <= comparator_res;
        PUNPKGLO, PUNPKGHI: res <= packer_res;
        default: res <= 0;
      endcase
    end
  end
endmodule