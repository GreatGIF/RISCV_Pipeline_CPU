module reg_file (
  input wire clk,
  input wire reset,

  input wire [4:0] rs1,
  input wire [4:0] rs2,
  output wire [31:0] rs1_data,
  output wire [31:0] rs2_data,

  input wire write_ena,
  input wire [4:0] rd,
  input wire [31:0] write_data
);

  reg [31:0] regs [0:31];

  // write
  always @(posedge clk) begin
    if (reset) begin
      integer i;
      for (i = 0; i < 32; i = i + 1) begin
        regs[i] <= 0;
      end
    end else begin
      if (write_ena) begin
        regs[rd] <= (rd == 0) ? 0 : write_data;
      end
    end
  end

  // read 
  wire wb_hazard_a;
  wire wb_hazard_b;
  assign wb_hazard_a = write_ena && (rd == rs1) && (rd != 0);
  assign wb_hazard_b = write_ena && (rd == rs2) && (rd != 0);
  assign rs1_data = (wb_hazard_a) ? write_data : regs[rs1];
  assign rs2_data = (wb_hazard_b) ? write_data : regs[rs2];


endmodule