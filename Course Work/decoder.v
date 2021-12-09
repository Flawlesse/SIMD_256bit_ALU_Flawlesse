// This module implements instruction decoder logic
module simd_decoder(
  input wire[15:0] inst,
  input wire clk,
  
  output reg[3:0] opcode,
  output reg[2:0] data_mode,
  output reg imm_flag,
  output reg[7:0] imm
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
  
  // This block prevents all invalid
  // operations and converts them into
  // NOP if needed.
  always @(posedge clk)
    begin
      // if incorrect data mode set
      // or opcode is not yet defined
      if ((inst[15:12] > 4'b1001) | (inst[11:9] > 3'b101))
        begin
          // convert to NOP
          opcode <= 0;
          data_mode <= 0;
          imm_flag <= 1;
          imm <= 0;
        end
      else
        begin
          // decode as normal instruction
          opcode <= inst[15:12];
          data_mode <= inst[11:9];
          imm_flag <= inst[8];
          imm <= inst[7:0];
        end
    end
  
endmodule