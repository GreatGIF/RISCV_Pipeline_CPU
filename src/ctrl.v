`include "./src/define.vh"

module ctrl (
  input wire [6:0] inst_op,
  output wire [2:0] op_type,
  output wire is_jalr,
  output wire [1:0] operand1_type,
  output wire [1:0] operand2_type,
  output wire is_br,
  output wire mem_read_ena,
  output wire mem_write_ena,
  output wire reg_write_ena,
  output wire mem2reg
);

  assign op_type= (inst_op == `Itype_load || inst_op == `Stype || inst_op == `Utype_lui || inst_op == `Utype_auipc) ? 3'b000 :
                  (inst_op == `Btype) ? 3'b001:
                  (inst_op == `Rtype) ? 3'b010:
                  (inst_op == `Itype_alu) ? 3'b011:
                  (inst_op == `Itype_jalr || inst_op == `Jtype) ? 3'b100 : 3'b111;
  assign is_jalr = (inst_op == `Itype_jalr) ? 1 : 0;
  assign operand1_type = (inst_op == `Itype_jalr || inst_op == `Jtype || inst_op == `Utype_auipc) ? `PC : 
                        (inst_op == `Utype_lui) ? `NULL : `REG;
  assign operand2_type = (inst_op == `Itype_load || inst_op == `Stype || inst_op == `Utype_auipc || inst_op == `Itype_alu || inst_op == `Utype_lui) ? `IMM :
                        (inst_op == `Itype_jalr || inst_op == `Jtype) ? `PC_PLUS4 : `REG;
  assign is_br = (inst_op == `Btype || inst_op == `Itype_jalr || inst_op == `Jtype) ? 1 : 0;
  assign mem_read_ena = (inst_op == `Itype_load) ? 1 : 0;
  assign mem_write_ena = (inst_op == `Stype) ? 1 : 0;
  assign reg_write_ena = (inst_op == `Itype_load || inst_op == `Rtype || inst_op == `Utype_auipc || inst_op == `Itype_alu || inst_op == `Itype_jalr || inst_op == `Utype_lui || inst_op == `Jtype) ? 1 : 0;
  assign mem2reg = (reg_write_ena && inst_op == `Itype_load) ? 1 : 0;


endmodule