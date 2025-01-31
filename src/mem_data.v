module mem_data #(
  parameter MEM_SIZE = 1024
)(
  input wire clk,
  input wire reset,
  input wire [31:0] addr,
  input wire [31:0] data,
  input wire read_ena,
  input wire write_ena,
  input wire [2:0] func3,
  output wire [31:0] out
);

  reg [7:0] mem [MEM_SIZE-1:0];

  initial begin
    $readmemh("./src/data/data.hex", mem);
  end

  // write
  wire [1:0] data_size = func3[1:0];
  always @(posedge clk) begin
    if (write_ena && !read_ena && !reset) begin
      if (data_size == 2'b00) begin
        mem[addr] <= data[7:0];
      end
      else if (data_size == 2'b01) begin
        mem[addr] <= data[7:0];
        mem[addr+1] <= data[15:8];
      end
      else if (data_size == 2'b10) begin
        mem[addr] <= data[7:0];
        mem[addr+1] <= data[15:8];
        mem[addr+2] <= data[23:16];
        mem[addr+3] <= data[31:24];
      end
    end
  end

  // read
  // assign out = {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};

  always @(negedge clk) begin
    if(reset) begin
      out <= 0;
    end else begin
      if (read_ena && !write_ena) begin
        case(func3)
          `LB : out <= {{24{mem[addr][7]}}, mem[addr]};
          `LH : out <= {{16{mem[addr+1][7]}}, mem[addr+1], mem[addr]};
          `LBU : out <= {24'b0, mem[addr]};
          `LHU : out <= {16'b0, mem[addr+1], mem[addr]};
          default : out <= {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};
        endcase
      end else begin
        out <= 0;
      end
    end
  end

endmodule