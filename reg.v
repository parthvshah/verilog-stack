// Write code for modules you need here
module reg16(input wire clk, reset, load, input wire [15:0] in, output wire [15:0] out);
	dfrl dl[15:0](clk, reset, load, in[15:0], out[15:0]);
endmodule

module reg16_8(input wire clk, reset, input wire [0:7] load, input wire [15:0] in, output wire [15:0] out0, out1, out2, out3, out4, out5, out6, out7);
	reg16 rg0(clk, reset, load[0], in, out0);
	reg16 rg1(clk, reset, load[1], in, out1);
	reg16 rg2(clk, reset, load[2], in, out2);
	reg16 rg3(clk, reset, load[3], in, out3);
	reg16 rg4(clk, reset, load[4], in, out4);
	reg16 rg5(clk, reset, load[5], in, out5);
	reg16 rg6(clk, reset, load[6], in, out6);
	reg16 rg7(clk, reset, load[7], in, out7);
endmodule

module out16_8(input wire [15:0] in0, in1, in2, in3, in4, in5, in6, in7, input wire [2:0] addr, output wire [15:0] out);
	mux8 m0({in0[0],in1[0],in2[0],in3[0],in4[0],in5[0],in6[0],in7[0]},addr[0],addr[1],addr[2],out[0]);
	mux8 m1({in0[1],in1[1],in2[1],in3[1],in4[1],in5[1],in6[1],in7[1]},addr[0],addr[1],addr[2],out[1]);
	mux8 m2({in0[2],in1[2],in2[2],in3[2],in4[2],in5[2],in6[2],in7[2]},addr[0],addr[1],addr[2],out[2]);
	mux8 m3({in0[3],in1[3],in2[3],in3[3],in4[3],in5[3],in6[3],in7[3]},addr[0],addr[1],addr[2],out[3]);
	mux8 m4({in0[4],in1[4],in2[4],in3[4],in4[4],in5[4],in6[4],in7[4]},addr[0],addr[1],addr[2],out[4]);
	mux8 m5({in0[5],in1[5],in2[5],in3[5],in4[5],in5[5],in6[5],in7[5]},addr[0],addr[1],addr[2],out[5]);
	mux8 m6({in0[6],in1[6],in2[6],in3[6],in4[6],in5[6],in6[6],in7[6]},addr[0],addr[1],addr[2],out[6]);
	mux8 m7({in0[7],in1[7],in2[7],in3[7],in4[7],in5[7],in6[7],in7[7]},addr[0],addr[1],addr[2],out[7]);
	mux8 m8({in0[8],in1[8],in2[8],in3[8],in4[8],in5[8],in6[8],in7[8]},addr[0],addr[1],addr[2],out[8]);
	mux8 m9({in0[9],in1[9],in2[9],in3[9],in4[9],in5[9],in6[9],in7[9]},addr[0],addr[1],addr[2],out[9]);
	mux8 m10({in0[10],in1[10],in2[10],in3[10],in4[10],in5[10],in6[10],in7[10]},addr[0],addr[1],addr[2],out[10]);
	mux8 m11({in0[11],in1[11],in2[11],in3[11],in4[11],in5[11],in6[11],in7[11]},addr[0],addr[1],addr[2],out[11]);
	mux8 m12({in0[12],in1[12],in2[12],in3[12],in4[12],in5[12],in6[12],in7[12]},addr[0],addr[1],addr[2],out[12]);
	mux8 m13({in0[13],in1[13],in2[13],in3[13],in4[13],in5[13],in6[13],in7[13]},addr[0],addr[1],addr[2],out[13]);
	mux8 m14({in0[14],in1[14],in2[14],in3[14],in4[14],in5[14],in6[14],in7[14]},addr[0],addr[1],addr[2],out[14]);
	mux8 m15({in0[15],in1[15],in2[15],in3[15],in4[15],in5[15],in6[15],in7[15]},addr[0],addr[1],addr[2],out[15]);

endmodule

module in2_16 (input wire op, input wire [15:0] in0, in1, output wire [15:0] out);
	mux2 m0[15:0](in0, in1, op, out);
endmodule

module reg_file (input wire clk, reset, wr, input wire [2:0] rd_addr_a, rd_addr_b, wr_addr, input wire [15:0] d_in, output wire [15:0] d_out_a, d_out_b);
	wire [0:7] load;
	wire [15:0] o0, o1, o2, o3, o4, o5, o6, o7;

	demux8 a(wr,wr_addr[2],wr_addr[1],wr_addr[0],load);
	reg16_8 b(clk, reset, load, d_in, o0, o1, o2, o3, o4, o5, o6, o7);

	out16_8 c(o0, o1, o2, o3, o4, o5, o6, o7, rd_addr_a, d_out_a);
	out16_8 d(o0, o1, o2, o3, o4, o5, o6, o7, rd_addr_b, d_out_b);
endmodule
