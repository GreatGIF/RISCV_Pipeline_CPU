module pc_ctrl (
  input wire clk,
  input wire reset,
  input wire stall,
  input wire br_ctrl,
  input wire [31:0] br_dst,
  output wire [31:0] current_pc
);

  reg [31:0] next_pc;

  always @(posedge clk) begin
    if (reset) begin
      current_pc <= 0;
    end else if(br_ctrl) begin
      current_pc <= br_dst;
    end else begin
      current_pc <= next_pc;
    end
  end

  always @(*) begin
    if (stall) begin
      next_pc = current_pc;
    end else begin
      next_pc = current_pc + 4;
    end
  end

  // always @(posedge clk) begin
  //   if (reset) begin
  //     current_pc <= 0;
  //   end else if (br_ctrl) begin
  //     current_pc <= br_dst;
  //   end else if (stall) begin
  //     current_pc <= current_pc;
  //   end else begin
  //     current_pc <= next_pc;
  //   end
  // end

  // always @(posedge clk) begin
  //   if (reset) begin
  //     next_pc <= 4;
  //   end else if (br_ctrl) begin
  //     next_pc <= br_dst + 4;
  //   end else if (stall) begin
  //     next_pc <= next_pc;
  //   end else begin
  //     next_pc <= next_pc + 4;
  //   end
  // end

endmodule