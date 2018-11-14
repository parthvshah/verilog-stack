`timescale 1 ns / 100 ps
`define TESTVECS 15
// module stack(input wire clk, reset, push, pop, input wire [15:0] value_in, output wire [15:0] value_out);
module tb;
  reg clk, reset, push, pop;
  // reg [2:0] rd_addr_a, rd_addr_b, wr_addr; 
  reg [15:0] value_in;
  wire [15:0] value_out;
  reg [17:0] test_vecs [0:(`TESTVECS-1)];

  integer i;
  initial begin $dumpfile("tb_stack3.vcd"); $dumpvars(0,tb); end
  initial begin reset = 1'b1; #12.5 reset = 1'b0; end
  initial clk = 1'b0; always #5 clk = ~clk;
  initial begin
    test_vecs[0][17] = 1'b1; test_vecs[0][16] = 1'b0; test_vecs[0][15:0] = 15'h13;
    test_vecs[1][17] = 1'b1; test_vecs[1][16] = 1'b0; test_vecs[1][15:0] = 15'ha5;
    test_vecs[2][17] = 1'b1; test_vecs[2][16] = 1'b0; test_vecs[2][15:0] = 15'h12;
    test_vecs[3][17] = 1'b1; test_vecs[3][16] = 1'b0; test_vecs[3][15:0] = 15'h14;
    test_vecs[4][17] = 1'b1; test_vecs[4][16] = 1'b0; test_vecs[4][15:0] = 15'ha5;
    test_vecs[5][17] = 1'b1; test_vecs[5][16] = 1'b0; test_vecs[5][15:0] = 15'h13;
    test_vecs[6][17] = 1'b1; test_vecs[6][16] = 1'b0; test_vecs[6][15:0] = 15'ha5;
    test_vecs[7][17] = 1'b1; test_vecs[7][16] = 1'b0; test_vecs[7][15:0] = 15'h12;
    test_vecs[8][17] = 1'b1; test_vecs[8][16] = 1'b0; test_vecs[8][15:0] = 15'h13;
    test_vecs[9][17] = 1'b1; test_vecs[9][16] = 1'b0; test_vecs[9][15:0] = 15'h14;
    test_vecs[10][17] = 1'b1; test_vecs[10][16] = 1'b0; test_vecs[10][15:0] = 15'h13;
    test_vecs[11][17] = 1'b1; test_vecs[11][16] = 1'b0; test_vecs[11][15:0] = 15'ha5;
    test_vecs[12][17] = 1'b0; test_vecs[12][16] = 1'b1; test_vecs[12][15:0] = 15'hxx;
    test_vecs[13][17] = 1'b0; test_vecs[13][16] = 1'b1; test_vecs[13][15:0] = 15'hxx;
    test_vecs[14][17] = 1'b1; test_vecs[14][16] = 1'b0; test_vecs[14][15:0] = 15'h14;
  end
  initial {push, pop, value_in} = 0;
  stack stk_0(clk, reset, push, pop, value_in, value_out);
initial begin
    #4 for(i=0;i<`TESTVECS;i=i+1)
      begin #10 {push, pop, value_in}=test_vecs[i]; end
    #100 $finish;
end
endmodule