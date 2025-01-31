`include "./src/define.vh"

module imm_gen (
  input wire [31:0] inst,
  output wire [31:0] imm
);

  always @(*) begin
    case(inst[6:0])
      `Itype_jalr: imm = {{20{inst[31]}}, inst[31:20]};
      `Itype_load: imm = {{20{inst[31]}}, inst[31:20]};
      `Itype_alu: imm = {{20{inst[31]}}, inst[31:20]};
      `Stype: imm = {{20{inst[31]}}, inst[31:25], inst[11:7]};
      `Btype: imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
      `Utype_lui: imm = {inst[31:12], 12'b0};
      `Utype_auipc: imm = {inst[31:12], 12'b0};
      `Jtype: imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
      default: imm = 0;
    endcase
  end
  
endmodule