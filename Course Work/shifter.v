// This module implements SLL, SRL, SRA
module simd_shifter(
  input wire[255:0] A,
  input wire[255:0] B,
  input wire[2:0] data_mode,
  input wire[1:0] sel,
  input wire imm_flag,
  input wire[7:0] imm_reg,

  output wire[255:0] out
);
  parameter SIMD_WIDTH = 256;
  reg[255:0] res;
  assign out = res;
  integer i;

  // register with shift step
  wire[7:0] shift_reg;
  assign shift_reg = (imm_flag) ? imm_reg : B[7:0];

  always @(*) begin

    case(sel)
      2'b11: begin // SLL
        case(data_mode)
          0: begin // 8bit
            for (i=0; i < SIMD_WIDTH/8; i=i+1) begin
              res[(i+1)*8 - 1 -:8] <= A[(i+1)*8 - 1 -:8] << shift_reg[2:0];
            end
          end
          1: begin // 16bit
            for (i=0; i < SIMD_WIDTH/16; i=i+1) begin
              res[(i+1)*16 - 1 -:16] <= A[(i+1)*16 - 1 -:16] << shift_reg[3:0];
            end
          end
          2: begin // 32bit
            for (i=0; i < SIMD_WIDTH/32; i=i+1) begin
              res[(i+1)*32 - 1 -:32] <= A[(i+1)*32 - 1 -:32] << shift_reg[4:0];
            end
          end
          3: begin // 64bit
            for (i=0; i < SIMD_WIDTH/64; i=i+1) begin
              res[(i+1)*64 - 1 -:64] <= A[(i+1)*64 - 1 -:64] << shift_reg[5:0];
            end
          end
          4: begin // 128bit
            for (i=0; i < SIMD_WIDTH/128; i=i+1) begin
              res[(i+1)*128 - 1 -:128] <= A[(i+1)*128 - 1 -:128] << shift_reg[6:0];
            end
          end
          default: begin // 256bit
            res <= A << shift_reg;
          end
        endcase
      end

      2'b00: begin // SRL
        case(data_mode)
          0: begin // 8bit
            for (i=0; i < SIMD_WIDTH/8; i=i+1) begin
              res[(i+1)*8 - 1 -:8] <= A[(i+1)*8 - 1 -:8] >> shift_reg[2:0];
            end
          end
          1: begin // 16bit
            for (i=0; i < SIMD_WIDTH/16; i=i+1) begin
              res[(i+1)*16 - 1 -:16] <= A[(i+1)*16 - 1 -:16] >> shift_reg[3:0];
            end
          end
          2: begin // 32bit
            for (i=0; i < SIMD_WIDTH/32; i=i+1) begin
              res[(i+1)*32 - 1 -:32] <= A[(i+1)*32 - 1 -:32] >> shift_reg[4:0];
            end
          end
          3: begin // 64bit
            for (i=0; i < SIMD_WIDTH/64; i=i+1) begin
              res[(i+1)*64 - 1 -:64] <= A[(i+1)*64 - 1 -:64] >> shift_reg[5:0];
            end
          end
          4: begin // 128bit
            for (i=0; i < SIMD_WIDTH/128; i=i+1) begin
              res[(i+1)*128 - 1 -:128] <= A[(i+1)*128 - 1 -:128] >> shift_reg[6:0];
            end
          end
          default: begin // 256bit
            res <= A >> shift_reg;
          end
        endcase
      end

      2'b01: begin // SRA
        case(data_mode)
          0: begin // 8bit
            for (i=0; i < SIMD_WIDTH/8; i=i+1) begin
              res[(i+1)*8 - 1 -:8] <= $signed(A[(i+1)*8 - 1 -:8]) >>> shift_reg[2:0];
            end
          end
          1: begin // 16bit
            for (i=0; i < SIMD_WIDTH/16; i=i+1) begin
              res[(i+1)*16 - 1 -:16] <= $signed(A[(i+1)*16 - 1 -:16]) >>> shift_reg[3:0];
            end
          end
          2: begin // 32bit
            for (i=0; i < SIMD_WIDTH/32; i=i+1) begin
              res[(i+1)*32 - 1 -:32] <= $signed(A[(i+1)*32 - 1 -:32]) >>> shift_reg[4:0];
            end
          end
          3: begin // 64bit
            for (i=0; i < SIMD_WIDTH/64; i=i+1) begin
              res[(i+1)*64 - 1 -:64] <= $signed(A[(i+1)*64 - 1 -:64]) >>> shift_reg[5:0];
            end
          end
          4: begin // 128bit
            for (i=0; i < SIMD_WIDTH/128; i=i+1) begin
              res[(i+1)*128 - 1 -:128] <= $signed(A[(i+1)*128 - 1 -:128]) >>> shift_reg[6:0];
            end
          end
          default: begin // 256bit
            res <= $signed(A) >>> shift_reg;
          end
        endcase
      end
      
      default: begin // NOP
        res <= 0;
      end
    endcase
  end
endmodule