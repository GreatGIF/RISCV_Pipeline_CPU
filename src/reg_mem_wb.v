module reg_mem_wb(
  input wire clk,
  input wire reset,
  input wire [31:0] me_mem_out,
  input wire [31:0] me_alu_out,
  input wire [4:0] me_rd,
  input wire me_mem2reg,
  input wire me_reg_write_ena,

  output reg [31:0] wb_mem_out,
  output reg [31:0] wb_alu_out,
  output reg [4:0] wb_rd,
  output reg wb_mem2reg,
  output reg wb_reg_write_ena
);

  always @(posedge clk) begin
    if (reset) begin
      wb_mem_out <= 0;
      wb_alu_out <= 0;
      wb_rd <= 0;
      wb_mem2reg <= 0;
      wb_reg_write_ena <= 0;
    end else begin
      wb_mem_out <= me_mem_out;
      wb_alu_out <= me_alu_out;
      wb_rd <= me_rd;
      wb_mem2reg <= me_mem2reg;
      wb_reg_write_ena <= me_reg_write_ena;
    end
  end

endmodule