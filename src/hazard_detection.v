module hazard_detection(
  input wire ex_mem_read_ena,
  input wire [4:0] ex_rd,
  input wire [4:0] id_rs1,
  input wire [4:0] id_rs2,
  input wire br_ctrl,
  output wire stall,
  output wire flush
);
  assign stall = ex_mem_read_ena && (ex_rd == id_rs1 || ex_rd == id_rs2);
  assign flush = br_ctrl;
endmodule