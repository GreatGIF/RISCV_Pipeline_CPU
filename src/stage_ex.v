`include "./src/define.vh"

module stage_ex (
  input wire [31:0] ex_pc,
  input wire [31:0] ex_rs1_data,
  input wire [31:0] ex_rs2_data,
  input wire [31:0] ex_imm,
  input wire [1:0] ex_operand1_type,
  input wire [1:0] ex_operand2_type,
  input wire ex_is_jalr,
  input wire [2:0] ex_func3,
  input wire [6:0] ex_func7,
  input wire [2:0] ex_op_type,
  input wire ex_is_br,
  input wire ex_mem_write_ena,

  input wire [1:0] forwardA,
  input wire [1:0] forwardB,
  input wire [31:0] me_alu_out,
  input wire [31:0] wb_reg_write_data,

  output wire [31:0] ex_alu_out,
  output wire [31:0] ex_rs2_data_st,
  output wire br_ctrl,
  output wire br_dst
);

  wire [3:0] alu_ctrl;
  wire [31:0] forward_operand1;
  wire [31:0] forward_operand2;
  wire [31:0] operand1;
  wire [31:0] operand2;
  wire [31:0] ex_alu_out;
  wire jump_ctrl;

  assign forward_operand1 = forwardA[1] ? me_alu_out : forwardA[0] ? wb_reg_write_data : ex_rs1_data;
  assign forward_operand2 = forwardB[1] ? me_alu_out : forwardB[0] ? wb_reg_write_data : ex_rs2_data;
  assign operand1 = (ex_operand1_type == `PC) ? ex_pc : ((ex_operand1_type == `NULL) ? 32'd0 : forward_operand1);
  assign operand2 = (ex_operand2_type == `IMM) ? ex_imm : ((ex_operand2_type == `PC_PLUS4) ? 32'd4 : forward_operand2);


  alu_ctrl u_alu_ctrl (
    .alu_op(ex_op_type),
    .func3(ex_func3),
    .func7(ex_func7[5]),
    .alu_ctrl(alu_ctrl)
  );

  alu u_alu (
    .alu_ctrl(alu_ctrl),
    .operand1(operand1),
    .operand2(operand2),
    .alu_out(ex_alu_out),
    .jump_ctrl(jump_ctrl)
  );

  wire [31:0] br_dst_operand1;
  wire [31:0] br_dst;
  assign br_dst_operand1 = ex_is_jalr ? ex_rs1_data : ex_pc;
  assign br_dst = br_dst_operand1 + ex_imm;

  assign br_ctrl = jump_ctrl && ex_is_br;
  assign ex_rs2_data_st = (ex_operand2_type == `IMM && ex_mem_write_ena) ? forward_operand2 : ex_rs2_data;

endmodule