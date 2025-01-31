module reg_if_id (
  input wire clk,
  input wire reset,
  input wire [31:0] if_inst,
  input wire [31:0] if_pc,
  output reg [31:0] id_inst,
  output reg [31:0] id_pc,
  input wire flush,
  input wire stall
);

  always @(posedge clk) begin
    if (reset || flush) begin
      id_inst <= 0;
      id_pc <= 0;
    end else if (stall) begin
      id_inst <= id_inst;
      id_pc <= id_pc;
    end else begin
      id_inst <= if_inst;
      id_pc <= if_pc;
    end
  end

endmodule