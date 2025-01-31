module stage_wb (
  input wire [31:0] wb_mem_out,
  input wire [31:0] wb_alu_out,
  input wire wb_mem2reg,
  output wire [31:0] wb_reg_write_data
);

  assign wb_reg_write_data = wb_mem2reg ? wb_mem_out : wb_alu_out;

endmodule