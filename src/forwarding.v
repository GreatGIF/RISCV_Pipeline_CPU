`include "./src/define.vh"

module forwarding (
  input wire[4:0] ex_rs1,
  input wire[4:0] ex_rs2,

  input wire me_reg_write_ena,
  input wire[4:0] me_rd,

  input wire wb_reg_write_ena,
  input wire[4:0] wb_rd,

  input wire me_mem_write_ena,
  input wire[4:0] me_rs2,

  output wire[1:0] forwardA,
  output wire[1:0] forwardB,
  output wire forwardB_st
);
  //forward for alu_operatant
  wire ex_hazard_a;
  wire ex_hazard_b;
  wire mem_hazard_a;
  wire mem_hazard_b;
  
  //forward for data_memory store write_data 
  wire mem_hazard_b_st;

  assign ex_hazard_a = me_reg_write_ena && (me_rd != 0) && (me_rd == ex_rs1); //me_rd != 0 : don't forward the result when rd is x0
  assign ex_hazard_b = me_reg_write_ena && (me_rd != 0) && (me_rd == ex_rs2);
  assign mem_hazard_a = wb_reg_write_ena && (wb_rd != 0) && (wb_rd == ex_rs1);  //wb_rd != 0 : don't forward the result when rd is x0
  assign mem_hazard_b = wb_reg_write_ena && (wb_rd != 0) && (wb_rd == ex_rs2);
  
  assign mem_hazard_b_st = me_mem_write_ena && (me_rs2 != 0) && (me_rs2 == ex_rs2);

  assign forwardA = {ex_hazard_a,mem_hazard_a};
  assign forwardB = {ex_hazard_b,mem_hazard_b};
  assign forwardB_st = mem_hazard_b_st;

endmodule