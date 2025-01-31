module processor (
  input wire clk,
  input wire reset
);

  wire br_ctrl;
  wire [31:0] br_dst;
  wire stall;
  wire [31:0] if_pc;
  wire [31:0] if_inst;
  wire flush;
  wire [31:0] id_inst;
  wire [31:0] id_pc;

  wire wb_reg_write_ena;
  wire [4:0] wb_rd;
  wire [31:0] wb_reg_write_data;
  wire [31:0] id_rs1_data;
  wire [31:0] id_rs2_data;
  wire [31:0] id_imm;
  wire [2:0] id_func3;
  wire [6:0] id_func7;
  wire [4:0] id_rd;
  wire id_is_br;
  wire id_mem_read_ena;
  wire id_mem2reg;
  wire [2:0] id_op_type;
  wire id_mem_write_ena;
  wire [1:0] id_operand1_type;
  wire [1:0] id_operand2_type;
  wire id_is_jalr;
  wire id_reg_write_ena;
  wire [4:0] id_rs1;
  wire [4:0] id_rs2;
  wire [4:0] ex_rs1;
  wire [4:0] ex_rs2;
  wire [31:0] ex_pc;
  wire [31:0] ex_rs1_data;
  wire [31:0] ex_rs2_data;
  wire [31:0] ex_rs2_data_st;
  wire [31:0] ex_imm;
  wire [2:0] ex_func3;
  wire [6:0] ex_func7;
  wire [4:0] ex_rd;
  wire ex_is_br;
  wire ex_mem_read_ena;
  wire ex_mem2reg;
  wire [2:0] ex_op_type;
  wire ex_mem_write_ena;
  wire [1:0] ex_operand1_type;
  wire [1:0] ex_operand2_type;
  wire ex_is_jalr;
  wire ex_reg_write_ena;
  wire [31:0] ex_alu_out;

  wire [1:0] forwardA;
  wire [1:0] forwardB;

  wire[4:0] me_rs2;
  wire[31:0] me_rs2_data_st;
  wire[31:0] me_alu_out;
  wire[4:0] me_rd;
  wire me_mem_read_ena;
  wire me_mem2reg;
  wire me_mem_write_ena;
  wire me_reg_write_ena;
  wire[31:0] me_mem_out;
  wire[2:0] me_func3;

  wire forwardB_st;

  wire[31:0] wb_mem_out;
  wire[31:0] wb_alu_out;
  wire wb_mem2reg;

  stage_if u_stage_if (
    .clk(clk),
    .reset(reset),
    .stall(stall),
    .br_ctrl(br_ctrl),
    .br_dst(br_dst),
    .if_pc(if_pc),
    .if_inst(if_inst)
  );

  reg_if_id u_reg_if_id (
    .clk(clk),
    .reset(reset),
    .if_pc(if_pc),
    .if_inst(if_inst),
    .id_pc(id_pc),
    .id_inst(id_inst),
    .flush(flush),
    .stall(stall)
  );

  stage_id u_stage_id (
    .clk(clk),
    .reset(reset),
    .id_inst(id_inst),
    .write_ena(wb_reg_write_ena),
    .write_data(wb_reg_write_data),
    .wb_rd(wb_rd),
    .stall(stall),
    .id_rs1_data(id_rs1_data),
    .id_rs2_data(id_rs2_data),
    .id_imm(id_imm),
    .id_operand1_type(id_operand1_type),
    .id_operand2_type(id_operand2_type),
    .id_rs1(id_rs1),
    .id_rs2(id_rs2),
    .id_rd(id_rd),
    .id_func3(id_func3),
    .id_func7(id_func7),
    .id_op_type(id_op_type),
    .id_is_jalr(id_is_jalr),
    .id_is_br(id_is_br),
    .id_mem_read_ena(id_mem_read_ena),
    .id_mem_write_ena(id_mem_write_ena),
    .id_reg_write_ena(id_reg_write_ena),
    .id_mem2reg(id_mem2reg)
  );

  reg_id_ex u_reg_id_ex (
    .clk(clk),
    .reset(reset),
    .flush(flush),
    .id_pc(id_pc),
    .id_rs1_data(id_rs1_data),
    .id_rs2_data(id_rs2_data),
    .id_imm(id_imm),
    .id_operand1_type(id_operand1_type),
    .id_operand2_type(id_operand2_type),
    .id_rs1(id_rs1),
    .id_rs2(id_rs2),
    .id_rd(id_rd),
    .id_func3(id_func3),
    .id_func7(id_func7),
    .id_op_type(id_op_type),
    .id_is_br(id_is_br),
    .id_mem_read_ena(id_mem_read_ena),
    .id_mem_write_ena(id_mem_write_ena),
    .id_reg_write_ena(id_reg_write_ena),
    .id_mem2reg(id_mem2reg),
    .id_is_jalr(id_is_jalr),
    .ex_pc(ex_pc),
    .ex_rs1_data(ex_rs1_data),
    .ex_rs2_data(ex_rs2_data),
    .ex_imm(ex_imm),
    .ex_operand1_type(ex_operand1_type),
    .ex_operand2_type(ex_operand2_type),
    .ex_rs1(ex_rs1),
    .ex_rs2(ex_rs2),
    .ex_rd(ex_rd),
    .ex_func3(ex_func3),
    .ex_func7(ex_func7),
    .ex_op_type(ex_op_type),
    .ex_is_br(ex_is_br),
    .ex_mem_read_ena(ex_mem_read_ena),
    .ex_mem_write_ena(ex_mem_write_ena),
    .ex_reg_write_ena(ex_reg_write_ena),
    .ex_mem2reg(ex_mem2reg),
    .ex_is_jalr(ex_is_jalr)
  );

  stage_ex u_stage_ex (
    .ex_pc(ex_pc),
    .ex_rs1_data(ex_rs1_data),
    .ex_rs2_data(ex_rs2_data),
    .ex_imm(ex_imm),
    .ex_operand1_type(ex_operand1_type),
    .ex_operand2_type(ex_operand2_type),
    .ex_is_jalr(ex_is_jalr),
    .ex_func3(ex_func3),
    .ex_func7(ex_func7),
    .ex_op_type(ex_op_type),
    .ex_is_br(ex_is_br),
    .ex_mem_write_ena(ex_mem_write_ena),
    .forwardA(forwardA),
    .forwardB(forwardB),
    .me_alu_out(me_alu_out),
    .wb_reg_write_data(wb_reg_write_data),
    .ex_alu_out(ex_alu_out),
    .ex_rs2_data_st(ex_rs2_data_st),
    .br_ctrl(br_ctrl),
    .br_dst(br_dst)
  );

  reg_ex_mem u_reg_ex_mem (
    .clk(clk),
    .reset(reset),
    .ex_rs2_data_st(ex_rs2_data_st),
    .ex_alu_out(ex_alu_out),
    .ex_rd(ex_rd),
    .ex_func3(ex_func3),
    .ex_mem_read_ena(ex_mem_read_ena),
    .ex_mem_write_ena(ex_mem_write_ena),
    .ex_reg_write_ena(ex_reg_write_ena),
    .ex_mem2reg(ex_mem2reg),
    .ex_rs2(ex_rs2),
    .me_rs2_data_st(me_rs2_data_st),
    .me_alu_out(me_alu_out),
    .me_rd(me_rd),
    .me_func3(me_func3),
    .me_mem_read_ena(me_mem_read_ena),
    .me_mem_write_ena(me_mem_write_ena),
    .me_reg_write_ena(me_reg_write_ena),
    .me_mem2reg(me_mem2reg),
    .me_rs2(me_rs2)
  );

  stage_mem u_stage_mem (
    .clk(clk),
    .reset(reset),
    .me_rs2_data_st(me_rs2_data_st),
    .me_alu_out(me_alu_out),
    .me_mem_read_ena(me_mem_read_ena),
    .me_mem_write_ena(me_mem_write_ena),
    .me_func3(me_func3),
    .forwardB_st(forwardB_st),
    .wb_reg_write_data(wb_reg_write_data),
    .me_mem_out(me_mem_out)
  );

  reg_mem_wb u_reg_mem_wb (
    .clk(clk),
    .reset(reset),
    .me_mem_out(me_mem_out),
    .me_alu_out(me_alu_out),
    .me_rd(me_rd),
    .me_mem2reg(me_mem2reg),
    .me_reg_write_ena(me_reg_write_ena),
    .wb_mem_out(wb_mem_out),
    .wb_alu_out(wb_alu_out),
    .wb_rd(wb_rd),
    .wb_mem2reg(wb_mem2reg),
    .wb_reg_write_ena(wb_reg_write_ena)
  );

  stage_wb u_stage_wb (
    .wb_mem_out(wb_mem_out),
    .wb_alu_out(wb_alu_out),
    .wb_mem2reg(wb_mem2reg),
    .wb_reg_write_data(wb_reg_write_data)
  );

  forwarding u_forwarding (
    .ex_rs1(ex_rs1),
    .ex_rs2(ex_rs2),
    .me_reg_write_ena(me_reg_write_ena),
    .me_rd(me_rd),
    .wb_reg_write_ena(wb_reg_write_ena),
    .wb_rd(wb_rd),
    .me_mem_write_ena(me_mem_write_ena),
    .me_rs2(me_rs2),
    .forwardA(forwardA),
    .forwardB(forwardB),
    .forwardB_st(forwardB_st)
  );

  hazard_detection u_hazard_detection (
    .ex_mem_read_ena(ex_mem_read_ena),
    .ex_rd(ex_rd),
    .id_rs1(id_rs1),
    .id_rs2(id_rs2),
    .br_ctrl(br_ctrl),
    .stall(stall),
    .flush(flush)
  );

endmodule