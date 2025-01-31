`include "./src/define.vh"

module alu (
  input wire [3:0] alu_ctrl,
  input wire [31:0] operand1,
  input wire [31:0] operand2,
  output wire [31:0] alu_out,
  output wire jump_ctrl
);

  assign jump_ctrl = (alu_ctrl == `JUMP) ? 1 :
                      (alu_ctrl == `NOTEQ || alu_ctrl == `SLT || alu_ctrl == `SLTU) ?
                      (alu_out != 0) : (alu_out == 0);
  
  always @(*) begin
    case (alu_ctrl)
      `AND        : alu_out = operand1 & operand2;           
      `OR         : alu_out = operand1 | operand2;           
      `ADD,`JUMP  : alu_out = operand1 + operand2;           
      `SUB,`NOTEQ : alu_out = operand1 - operand2;           
      `XOR        : alu_out = operand1 ^ operand2;           
      `SLT,`SGE   : alu_out = ($signed(operand1)) < ($signed(operand2)) ? 32'b1 : 32'b0;   
      `SLTU,`SGEU : alu_out = operand1 < operand2 ? 32'b1 : 32'b0;   
      `SLL        : alu_out = operand1 << operand2[4:0];
      `SRL        : alu_out = operand1 >> operand2[4:0];
      `SRA        : alu_out = ($signed(operand1)) >>> operand2[4:0];
      default: alu_out = 0;
    endcase
  end

endmodule