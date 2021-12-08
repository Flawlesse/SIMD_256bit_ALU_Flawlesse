`include "adder.v"
`include "shifter.v"
`include "comparator.v"
`include "packer.v"


module executor(
  input wire[3:0] opcode,
  input wire[2:0] data_mode,
  input wire imm_flag,
  input wire[7:0] imm,
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
  
  // Instantiating ALU submodules
  simd_adder adder(
  	
  );
  simd_shifter shifter(
  	
  );
  simd_comparator comparator(
  	
  );
  simd_packer packer(
  	
  );
  
  
  // Inner registers
  reg[255:0] A_reg;
  reg[255:0] B_reg;
  
  // Outputs from modules
  reg[255:0] adder_res;
  reg[255:0] shifter_res;
  reg[255:0] comparator_res;
  reg[255:0] packer_res;
  
  // General output
  reg[255:0] res;
  assign out = res;
  
  
  
  always @(posedge clk) begin
    if (rst) begin
      A_reg <= {256{1'b0}};
      B_reg <= {256{1'b0}};
    end else begin
      A_reg <= in_A;
      B_reg <= in_B;
    end
  end
  
  always @(posedge clk) begin
    if (rst || opcode == NOP) begin
      // just perform NOP
      res <= {256{1'b0}};
    end else begin
      case(opcode)
        PADD, PSUB: res <= adder_res;
        PSLL, PSRL, PSRA: res <= shifter_res;
        PCMPEQ, PCMPGT: res <= comparator_res;
        PUNPKGLO, PUNPKGHI: res <= packer_res;
      endcase
    end
  end
  
endmodule