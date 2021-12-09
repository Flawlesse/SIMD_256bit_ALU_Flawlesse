// This module implements both CMPEQ and CMPGT
module simd_comparator(
  input wire[255:0] A,
  input wire[255:0] B,
  input wire[2:0] data_mode,
  input wire gt_flag,
  
  output wire[255:0] out
);
  parameter SIMD_WIDTH = 256;
  reg[255:0] res;
  assign out = res;
  integer i;
  
  
  always @(*) begin
    case(data_mode)
      0: begin // 8bit
        for (i=0; i < SIMD_WIDTH/8; i=i+1) begin
          if (gt_flag) begin
            res[(i+1)*8 - 1 -:8] <= {8{( $signed(A[(i+1)*8 - 1 -:8]) > $signed(B[(i+1)*8 - 1 -:8]) )}};
          end else begin
            res[(i+1)*8 - 1 -:8] <= {8{( A[(i+1)*8 - 1 -:8] == B[(i+1)*8 - 1 -:8] )}};
          end
        end
      end
      1: begin // 16bit
        for (i=0; i < SIMD_WIDTH/16; i=i+1) begin
          if (gt_flag) begin
            res[(i+1)*16 - 1 -:16] <= {16{( $signed(A[(i+1)*16 - 1 -:16]) > $signed(B[(i+1)*16 - 1 -:16]) )}};
          end else begin
            res[(i+1)*16 - 1 -:16] <= {16{( A[(i+1)*16 - 1 -:16] == B[(i+1)*16 - 1 -:16] )}};
          end
      end
      2: begin // 32bit
        for (i=0; i < SIMD_WIDTH/32; i=i+1) begin
          if (gt_flag) begin
            res[(i+1)*32 - 1 -:32] <= {32{( $signed(A[(i+1)*32 - 1 -:32]) > $signed(B[(i+1)*32 - 1 -:32]) )}};
          end else begin
            res[(i+1)*32 - 1 -:32] <= {32{( A[(i+1)*32 - 1 -:32] == B[(i+1)*32 - 1 -:32] )}};
          end
      end
      3: begin // 64bit
        for (i=0; i < SIMD_WIDTH/64; i=i+1) begin
          if (gt_flag) begin
            res[(i+1)*64 - 1 -:64] <= {64{( $signed(A[(i+1)*64 - 1 -:64]) > $signed(B[(i+1)*64 - 1 -:64]) )}};
          end else begin
            res[(i+1)*64 - 1 -:64] <= {64{( A[(i+1)*64 - 1 -:64] == B[(i+1)*64 - 1 -:64] )}};
          end
      end
      4: begin // 128bit
        for (i=0; i < SIMD_WIDTH/128; i=i+1) begin
          if (gt_flag) begin
            res[(i+1)*128 - 1 -:128] <= {128{( $signed(A[(i+1)*128 - 1 -:128]) > $signed(B[(i+1)*128 - 1 -:128]) )}};
          end else begin
            res[(i+1)*128 - 1 -:128] <= {128{( A[(i+1)*128 - 1 -:128] == B[(i+1)*128 - 1 -:128] )}};
          end
      end
      default: begin // 256bit
        if (gt_flag) begin
          res <= {256{( $signed(A) > $signed(B) )}};
        end else begin
          res <= {256{( A == B )}};
        end
      end
    endcase
  end
endmodule