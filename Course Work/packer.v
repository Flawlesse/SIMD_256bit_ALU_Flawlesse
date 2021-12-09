// This module implements both UNPCKGLO and UNPCKGHI
`timescale 1ns/1ps

module simd_packer(
  input wire[255:0] A,
  input wire[255:0] B,
  input wire[2:0] data_mode,
  input wire hi_flag,
  
  output wire[255:0] out
);
  parameter SIMD_WIDTH = 256;
  reg[255:0] res;
  assign out = res;
  integer i;
  
  
  // A[part]+B[part]
  always @(*) begin
    case(data_mode)
      0: begin // 8bit
        for (i=0; i < SIMD_WIDTH/(8*2); i=i+1) begin
          if (hi_flag) begin
            res[(i+1)*8*2 - 1 -:8*2] <= {A[(i+8+1)*8 - 1 -:8], B[(i+8+1)*8 - 1 -:8]};
          end else begin
            res[(i+1)*8*2 - 1 -:8*2] <= {A[(i+1)*8 - 1 -:8], B[(i+1)*8 - 1 -:8]};
          end
        end
      end
      1: begin // 16bit
        for (i=0; i < SIMD_WIDTH/(16*2); i=i+1) begin
          if (hi_flag) begin
            res[(i+1)*16*2 - 1 -:16*2] <= {A[(i+16+1)*16 - 1 -:16], B[(i+16+1)*16 - 1 -:16]};
          end else begin
            res[(i+1)*16*2 - 1 -:16*2] <= {A[(i+1)*16 - 1 -:16], B[(i+1)*16 - 1 -:16]};
          end
        end
      end
      2: begin // 32bit
        for (i=0; i < SIMD_WIDTH/(32*2); i=i+1) begin
          if (hi_flag) begin
            res[(i+1)*32*2 - 1 -:32*2] <= {A[(i+32+1)*32 - 1 -:32], B[(i+32+1)*32 - 1 -:32]};
          end else begin
            res[(i+1)*32*2 - 1 -:32*2] <= {A[(i+1)*32 - 1 -:32], B[(i+1)*32 - 1 -:32]};
          end
        end
      end
      3: begin // 64bit
        for (i=0; i < SIMD_WIDTH/(64*2); i=i+1) begin
          if (hi_flag) begin
            res[(i+1)*64*2 - 1 -:64*2] <= {A[(i+64+1)*64 - 1 -:64], B[(i+64+1)*64 - 1 -:64]};
          end else begin
            res[(i+1)*64*2 - 1 -:64*2] <= {A[(i+1)*64 - 1 -:64], B[(i+1)*64 - 1 -:64]};
          end
        end
      end
      4: begin // 128bit
        if (hi_flag) begin
          res <= {A[255:128], B[255:128]};
        end else begin
          res <= {A[127:0], B[127:0]};
        end
      end
      // if 256bit selected, return A register values 
      default: begin
        res <= A;
      end
    endcase
  end
endmodule