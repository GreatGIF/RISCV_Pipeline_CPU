module mem_inst #(
  parameter MEM_SIZE = 1024
) (
  input wire [31:0] pc,
  output wire [31:0] inst
);

  reg [7:0] mem [MEM_SIZE-1:0];

  initial begin
    $readmemh("./src/data/inst.hex", mem);
  end

  assign inst = {mem[pc+3], mem[pc+2], mem[pc+1], mem[pc]};

endmodule