module reg_ex_mem (
  input wire clk,
  input wire reset,
  input wire [31:0] ex_rs2_data_st,
  input wire [31:0] ex_alu_out,
  input wire [4:0] ex_rd,
  input wire [2:0] ex_func3,
  input wire ex_mem_read_ena,
  input wire ex_mem_write_ena,
  input wire ex_reg_write_ena,
  input wire ex_mem2reg,
  input wire [4:0] ex_rs2,

  output wire [31:0] me_rs2_data_st,
  output wire [31:0] me_alu_out,
  output wire [4:0] me_rd,
  output wire [2:0] me_func3,
  output wire me_mem_read_ena,
  output wire me_mem_write_ena,
  output wire me_reg_write_ena,
  output wire me_mem2reg,
  output wire [4:0] me_rs2
);

  always @(posedge clk) begin
    if (reset) begin
      me_rs2_data_st <= 0;
      me_alu_out <= 0;
      me_rd <= 0;
      me_func3 <= 0;
      me_mem_read_ena <= 0;
      me_mem_write_ena <= 0;
      me_reg_write_ena <= 0;
      me_mem2reg <= 0;
      me_rs2 <= 0;
    end else begin
      me_rs2_data_st <= ex_rs2_data_st;
      me_alu_out <= ex_alu_out;
      me_rd <= ex_rd;
      me_func3 <= ex_func3;
      me_mem_read_ena <= ex_mem_read_ena;
      me_mem_write_ena <= ex_mem_write_ena;
      me_reg_write_ena <= ex_reg_write_ena;
      me_mem2reg <= ex_mem2reg;
    end
  end

endmodule