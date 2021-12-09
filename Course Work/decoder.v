// This module implements instruction decoder logic
`timescale 1ns/1ps

module simd_decoder(
  input wire[15:0] inst,
  
  output wire[3:0] opcode,
  output wire[2:0] data_mode,
  output wire imm_flag,
  output wire[7:0] imm
);
  /*
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
  */
  
  reg[3:0] opcode_r;
  assign opcode = opcode_r;
  reg[2:0] data_mode_r;
  assign data_mode = data_mode_r;
  reg imm_flag_r;
  assign imm_flag = imm_flag_r;
  reg[7:0] imm_r;
  assign imm = imm_r;
  
  
  // This block prevents all invalid
  // operations and converts them into
  // NOP if needed.
  always @(inst)
    begin
      // if incorrect data mode set
      // or opcode is not yet defined
      if ((inst[15:12] > 4'b1001) | (inst[11:9] > 3'b101))
        begin
          // convert to NOP
          opcode_r <= 0;
          data_mode_r <= 0;
          imm_flag_r <= 1;
          imm_r <= 0;
        end
      else
        begin
          // decode as normal instruction
          opcode_r <= inst[15:12];
          data_mode_r <= inst[11:9];
          imm_flag_r <= inst[8];
          imm_r <= inst[7:0];
        end
    end
  
endmodule