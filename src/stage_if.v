module stage_if (
  input wire clk,
  input wire reset,
  input wire stall,
  input wire br_ctrl,
  input wire [31:0] br_dst,

  output wire [31:0] if_pc,
  output wire [31:0] if_inst
);
  
  pc_ctrl u_pc_ctrl (
    .clk(clk),
    .reset(reset),
    .stall(stall),
    .br_ctrl(br_ctrl),
    .br_dst(br_dst),
    .current_pc(if_pc)
  );

  mem_inst #(
    .MEM_SIZE(1024)
  ) u_mem_inst (
    .pc(if_pc),
    .inst(if_inst)
  );

endmodule