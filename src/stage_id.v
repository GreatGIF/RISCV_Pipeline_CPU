module stage_id (
  input wire clk,
  input wire reset,
  input wire [31:0] id_inst,

  input wire write_ena,
  input wire [31:0] write_data,
  input wire [4:0] wb_rd,
  input wire stall,

  output wire [31:0] id_rs1_data,
  output wire [31:0] id_rs2_data,
  output wire [31:0] id_imm,
  output wire [1:0] id_operand1_type,
  output wire [1:0] id_operand2_type,

  output wire [4:0] id_rs1,
  output wire [4:0] id_rs2,
  output wire [4:0] id_rd,
  output wire [2:0] id_func3,
  output wire [6:0] id_func7,

  output wire [2:0] id_op_type,
  output wire id_is_jalr,
  output wire id_is_br,
  output wire id_mem_read_ena,
  output wire id_mem_write_ena,
  output wire id_reg_write_ena,
  output wire id_mem2reg

);

  reg_file u_reg_file (
    .clk(clk),
    .reset(reset),
    .rs1(id_inst[19:15]),
    .rs2(id_inst[24:20]),
    .rs1_data(id_rs1_data),
    .rs2_data(id_rs2_data),
    .write_ena(write_ena),
    .rd(wb_rd),
    .write_data(write_data)
  );

  imm_gen u_imm_gen (
    .inst(id_inst),
    .imm(id_imm)
  );

  wire [2:0] op_type;
  wire is_jalr;
  wire [1:0] operand1_type;
  wire [1:0] operand2_type;
  wire is_br;
  wire mem_read_ena;
  wire mem_write_ena;
  wire reg_write_ena;
  wire mem2reg;

  ctrl u_ctrl (
    .inst_op(id_inst[6:0]),
    .op_type(op_type),
    .is_jalr(is_jalr),
    .operand1_type(operand1_type),
    .operand2_type(operand2_type),
    .is_br(is_br),
    .mem_read_ena(mem_read_ena),
    .mem_write_ena(mem_write_ena),
    .reg_write_ena(reg_write_ena),
    .mem2reg(mem2reg)
  );

  assign id_rs1 = id_inst[19:15];
  assign id_rs2 = id_inst[24:20];
  assign id_rd = id_inst[11:7];
  assign id_func3 = id_inst[14:12];
  assign id_func7 = id_inst[31:25];

  assign id_op_type = stall ? 0 : op_type;
  assign id_is_jalr = stall ? 0 : is_jalr;
  assign id_operand1_type = stall ? 0 : operand1_type;
  assign id_operand2_type = stall ? 0 : operand2_type;
  assign id_is_br = stall ? 0 : is_br;
  assign id_mem_read_ena = stall ? 0 : mem_read_ena;  
  assign id_mem_write_ena = stall ? 0 : mem_write_ena;
  assign id_reg_write_ena = stall ? 0 : reg_write_ena;
  assign id_mem2reg = stall ? 0 : mem2reg;

  

endmodule