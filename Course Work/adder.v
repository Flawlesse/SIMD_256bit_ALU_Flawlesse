// This module implements both ADD and SUB
`timescale 1ns/1ps

module simd_adder(
  input wire[255:0] A,
  input wire[255:0] B,
  input wire[2:0] data_mode,
  input wire sub_flag,
  input wire imm_flag,
  input wire[7:0] imm_reg,
  
  output wire[255:0] out
);
  parameter SIMD_WIDTH = 256;
  reg[255:0] res;
  assign out = res;
  integer i;
  
  always @(*) begin
    if (imm_flag) begin
      // Immediate operation
      case(data_mode)
        0: begin // 8bit
          for (i=0; i < SIMD_WIDTH/8; i=i+1) begin
            res[(i+1)*8 - 1 -:8] <= (sub_flag) ? A[(i+1)*8 - 1 -:8] - imm_reg: A[(i+1)*8 - 1 -:8] + imm_reg;
          end
        end
        1: begin // 16bit
          for (i=0; i < SIMD_WIDTH/16; i=i+1) begin
            res[(i+1)*16 - 1 -:16] <= (sub_flag) ? A[(i+1)*16 - 1 -:16] - { {8{imm_reg[7]}}, imm_reg}: A[(i+1)*16 - 1 -:16] + { {8{imm_reg[7]}}, imm_reg};
          end
        end
        2: begin // 32bit
          for (i=0; i < SIMD_WIDTH/32; i=i+1) begin
            res[(i+1)*32 - 1 -:32] <= (sub_flag) ? A[(i+1)*32 - 1 -:32] - { {24{imm_reg[7]}}, imm_reg}: A[(i+1)*32 - 1 -:32] + { {24{imm_reg[7]}}, imm_reg};
          end
        end
        3: begin // 64bit
          for (i=0; i < SIMD_WIDTH/64; i=i+1) begin
            res[(i+1)*64 - 1 -:64] <= (sub_flag) ? A[(i+1)*64 - 1 -:64] - { {56{imm_reg[7]}}, imm_reg}: A[(i+1)*64 - 1 -:64] + { {56{imm_reg[7]}}, imm_reg};
          end
        end
        4: begin // 128bit
          for (i=0; i < SIMD_WIDTH/128; i=i+1) begin
            res[(i+1)*128 - 1 -:128] <= (sub_flag) ? A[(i+1)*128 - 1 -:128] - {{ 120{imm_reg[7]}}, imm_reg}: A[(i+1)*128 - 1 -:128] + { {120{imm_reg[7]}}, imm_reg};
          end
        end
        default: begin // 256bit
          res <= (sub_flag) ? A - { {248{imm_reg[7]}}, imm_reg}: A + { {248{imm_reg[7]}}, imm_reg};
        end
      endcase
    end else begin
      // Register operation
      case(data_mode)
      	0: begin // 8bit
          for (i=0; i < SIMD_WIDTH/8; i=i+1) begin
            res[(i+1)*8 - 1 -:8] <= (sub_flag) ? A[(i+1)*8 - 1 -:8] - B[(i+1)*8 - 1 -:8]: A[(i+1)*8 - 1 -:8] + B[(i+1)*8 - 1 -:8];
          end
        end
        1: begin // 16bit
          for (i=0; i < SIMD_WIDTH/16; i=i+1) begin
            res[(i+1)*16 - 1 -:16] <= (sub_flag) ? A[(i+1)*16 - 1 -:16] - B[(i+1)*16 - 1 -:16]: A[(i+1)*16 - 1 -:16] + B[(i+1)*16 - 1 -:16];
          end
        end
        2: begin // 32bit
          for (i=0; i < SIMD_WIDTH/32; i=i+1) begin
            res[(i+1)*32 - 1 -:32] <= (sub_flag) ? A[(i+1)*32 - 1 -:32] - B[(i+1)*32 - 1 -:32]: A[(i+1)*32 - 1 -:32] + B[(i+1)*32 - 1 -:32];
          end
        end
        3: begin // 64bit
          for (i=0; i < SIMD_WIDTH/64; i=i+1) begin
            res[(i+1)*64 - 1 -:64] <= (sub_flag) ? A[(i+1)*64 - 1 -:64] - B[(i+1)*64 - 1 -:64]: A[(i+1)*64 - 1 -:64] + B[(i+1)*64 - 1 -:64];
          end
        end
        4: begin // 128bit
          for (i=0; i < SIMD_WIDTH/128; i=i+1) begin
            res[(i+1)*128 - 1 -:128] <= (sub_flag) ? A[(i+1)*128 - 1 -:128] - B[(i+1)*128 - 1 -:128]: A[(i+1)*128 - 1 -:128] + B[(i+1)*128 - 1 -:128];
          end
        end
        default: begin // 256bit
          res <= (sub_flag) ? A - B: A + B;
        end
      endcase
    end
  end
  
endmodule