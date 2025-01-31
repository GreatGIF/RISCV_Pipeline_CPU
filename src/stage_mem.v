`include "./src/define.vh"

module stage_mem(
  input wire clk,
  input wire reset,
  input wire [31:0] me_rs2_data_st,
  input wire [31:0] me_alu_out,
  input wire me_mem_read_ena,
  input wire me_mem_write_ena,
  input wire [2:0] me_func3,

  input wire forwardB_st,
  input wire [31:0] wb_reg_write_data,

  output wire [31:0] me_mem_out
);

  wire [31:0] mem_write_data;
  assign mem_write_data = forwardB_st ? wb_reg_write_data : me_rs2_data_st;

  mem_data #(
    .MEM_SIZE(1024)
  ) u_mem_data (
    .clk(clk),
    .reset(reset),
    .addr(me_alu_out),
    .data(mem_write_data),
    .read_ena(me_mem_read_ena),
    .write_ena(me_mem_write_ena),
    .func3(me_func3),
    .out(me_mem_out)
  );

endmodule