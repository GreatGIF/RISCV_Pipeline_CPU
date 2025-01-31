module reg_id_ex (
  input wire clk,
  input wire reset,
  input wire flush,

  input wire [31:0] id_pc,
  input wire [31:0] id_rs1_data,
  input wire [31:0] id_rs2_data,
  input wire [31:0] id_imm,
  input wire [1:0] id_operand1_type,
  input wire [1:0] id_operand2_type,
  input wire [4:0] id_rs1,
  input wire [4:0] id_rs2,
  input wire [4:0] id_rd,
  input wire [2:0] id_func3,
  input wire [6:0] id_func7,
  input wire [2:0] id_op_type,
  input wire id_is_br,
  input wire id_mem_read_ena,
  input wire id_mem_write_ena,
  input wire id_reg_write_ena,
  input wire id_mem2reg,
  input wire id_is_jalr,
  
  output reg [31:0] ex_pc,
  output wire [31:0] ex_rs1_data,
  output wire [31:0] ex_rs2_data,
  output wire [31:0] ex_imm,
  output wire [1:0] ex_operand1_type,
  output wire [1:0] ex_operand2_type,
  output wire [4:0] ex_rs1,
  output wire [4:0] ex_rs2,
  output wire [4:0] ex_rd,
  output wire [2:0] ex_func3,
  output wire [6:0] ex_func7,
  output wire [2:0] ex_op_type,
  output wire ex_is_br,
  output wire ex_mem_read_ena,
  output wire ex_mem_write_ena,
  output wire ex_reg_write_ena,
  output wire ex_mem2reg,
  output wire ex_is_jalr
);

  always @(posedge clk) begin
    if (reset || flush) begin
      ex_pc <= 0;
      ex_rs1_data <= 0;
      ex_rs2_data <= 0;
      ex_imm <= 0;
      ex_operand1_type <= 0;
      ex_operand2_type <= 0;
      ex_rs1 <= 0;
      ex_rs2 <= 0;
      ex_rd <= 0;
      ex_func3 <= 0;
      ex_func7 <= 0;
      ex_op_type <= 0;
      ex_is_br <= 0;
      ex_mem_read_ena <= 0;
      ex_mem_write_ena <= 0;
      ex_reg_write_ena <= 0;
      ex_mem2reg <= 0;
      ex_is_jalr <= 0;
    end else begin
      ex_pc <= id_pc;
      ex_rs1_data <= id_rs1_data;
      ex_rs2_data <= id_rs2_data;
      ex_imm <= id_imm;
      ex_operand1_type <= id_operand1_type;
      ex_operand2_type <= id_operand2_type;
      ex_rs1 <= id_rs1;
      ex_rs2 <= id_rs2;
      ex_rd <= id_rd;
      ex_func3 <= id_func3;
      ex_func7 <= id_func7;
      ex_op_type <= id_op_type;
      ex_is_br <= id_is_br;
      ex_mem_read_ena <= id_mem_read_ena;
      ex_mem_write_ena <= id_mem_write_ena;
      ex_reg_write_ena <= id_reg_write_ena;
      ex_mem2reg <= id_mem2reg;
      ex_is_jalr <= id_is_jalr;
    end
  end

endmodule