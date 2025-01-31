module alu_ctrl (
  input wire [2:0] alu_op,
  input wire [2:0] func3,
  input wire func7,
  output wire [3:0] alu_ctrl
);

  always @(*) begin
    case (alu_op)
      3'b000: begin //`Itype_load, `Stype, `Utype_lui, `Utype_auipc
        alu_ctrl = `ADD;
      end
      3'b001: begin //`Btype
        case (func3)
          `B_BEQ: alu_ctrl = `SUB;
          `B_BNE: alu_ctrl = `NOTEQ;
          `B_BLT: alu_ctrl = `SLT;
          `B_BGE: alu_ctrl = `SGE;
          `B_BLTU: alu_ctrl = `SLTU;
          `B_BGEU: alu_ctrl = `SGEU;
          default: alu_ctrl = 4'b1111;
        endcase
      end
      3'b010: begin //`Rtype
        case ({func3, func7})
          `R_ADD: alu_ctrl = `ADD;
          `R_SUB: alu_ctrl = `SUB;
          `R_SLL: alu_ctrl = `SLL;
          `R_SLT: alu_ctrl = `SLT;
          `R_SLTU: alu_ctrl = `SLTU;
          `R_XOR: alu_ctrl = `XOR;
          `R_SRL: alu_ctrl = `SRL;
          `R_SRA: alu_ctrl = `SRA;
          `R_OR: alu_ctrl = `OR;
          `R_AND: alu_ctrl = `AND;
          default: alu_ctrl = 4'b1111;
        endcase
      end 
      3'b011: begin //`Itype_alu
        case (func3)
          `I_ADDI: alu_ctrl = `ADD;
          `I_SLLI: alu_ctrl = (func7 == 0) ? `SLL : 4'b1111;
          `I_SLTI: alu_ctrl = `SLT;
          `I_SLTIU: alu_ctrl = `SLTU;
          `I_XORI: alu_ctrl = `XOR;
          `I_SRLI: alu_ctrl = (func7 == 0) ? `SRL : (func7 == 1) ? `SRA : 4'b1111;
          `I_ORI: alu_ctrl = `OR;
          `I_ANDI: alu_ctrl = `AND;
          default: alu_ctrl = 4'b1111;
        endcase
      end
      3'b100: begin //`Itype_jalr, `Jtype
        alu_ctrl = `JUMP;
      end
      default: begin
        alu_ctrl = 4'b1111;
      end
    endcase
  end
endmodule