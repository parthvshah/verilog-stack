module mux_16(input wire [15:0] i0,i1,i2,i3, input wire op0, op1, output wire [15:0] out);
	mux4 a0({i0[0],i1[0],i2[0],i3[0]}, op0, op1, out[0]);
	mux4 a1({i0[1],i1[1],i2[1],i3[1]}, op0, op1, out[1]);
	mux4 a2({i0[2],i1[2],i2[2],i3[2]}, op0, op1, out[2]);
	mux4 a3({i0[3],i1[3],i2[3],i3[3]}, op0, op1, out[3]);
	mux4 a4({i0[4],i1[4],i2[4],i3[4]}, op0, op1, out[4]);
	mux4 a5({i0[5],i1[5],i2[5],i3[5]}, op0, op1, out[5]);
	mux4 a6({i0[6],i1[6],i2[6],i3[6]}, op0, op1, out[6]);
	mux4 a7({i0[7],i1[7],i2[7],i3[7]}, op0, op1, out[7]);
	mux4 a8({i0[8],i1[8],i2[8],i3[8]}, op0, op1, out[8]);
	mux4 a9({i0[9],i1[9],i2[9],i3[9]}, op0, op1, out[9]);
	mux4 a10({i0[10],i1[10],i2[10],i3[10]}, op0, op1, out[10]);
	mux4 a11({i0[11],i1[11],i2[11],i3[11]}, op0, op1, out[11]);
	mux4 a12({i0[12],i1[12],i2[12],i3[12]}, op0, op1, out[12]);
	mux4 a13({i0[13],i1[13],i2[13],i3[13]}, op0, op1, out[13]);
	mux4 a14({i0[14],i1[14],i2[14],i3[14]}, op0, op1, out[14]);
	mux4 a15({i0[15],i1[15],i2[15],i3[15]}, op0, op1, out[15]);
endmodule

module mux_16_2(input wire [15:0] i0,i1, input wire op, output wire [15:0] out);
    mux2 a0(i0[0],i1[0],op,out[0]);
    mux2 a1(i0[1],i1[1],op,out[1]);
    mux2 a2(i0[2],i1[2],op,out[2]);
    mux2 a3(i0[3],i1[3],op,out[3]);
    mux2 a4(i0[4],i1[4],op,out[4]);
    mux2 a5(i0[5],i1[5],op,out[5]);
    mux2 a6(i0[6],i1[6],op,out[6]);
    mux2 a7(i0[7],i1[7],op,out[7]);
    mux2 a8(i0[8],i1[8],op,out[8]);
    mux2 a9(i0[9],i1[9],op,out[9]);
    mux2 a10(i0[10],i1[10],op,out[10]);
    mux2 a11(i0[11],i1[11],op,out[11]);
    mux2 a12(i0[12],i1[12],op,out[12]);
    mux2 a13(i0[13],i1[13],op,out[13]);
    mux2 a14(i0[14],i1[14],op,out[14]);
    mux2 a15(i0[15],i1[15],op,out[15]);
endmodule

// reg_file (input wire clk, reset, wr, input wire [2:0] rd_addr_a, rd_addr_b, wr_addr, input wire [15:0] d_in, output wire [15:0] d_out_a, d_out_b);
 
module stack(input wire clk, reset, push, pop, input wire [15:0] value_in, output wire [15:0] value_out);

    wire [15:0] reset_write, current_top, d_care_0, d_care_1;
    reg_file rf0(clk, reset, 1'b0, 3'b000, 3'bxxx, 3'bxxx, 16'bxxxxxxxxxxxxxxxx, current_top, d_care_0);

    // Reset conditions 
    // mux_16_2 m1(current_top, 16'b0000000000000001, reset, reset_write);
    // reg_file rf3(clk, reset, 1'b1, 3'bxxx, 3'bxxx, 3'b000, reset_write, d_care_0, d_care_1);
    
    wire [15:0] incremented_address, decremented_address;
	wire carry_add, carry_sub;
	fas16 a1(16'b0000000000000001, current_top[15:0], 1'b0, incremented_address[15:0], carry_add);
	fas16 a2(16'b0000000000000001, current_top[15:0], 1'b1, decremented_address[15:0], carry_sub);

    reg_file rf2(clk, reset, 1'b0, {current_top[2],current_top[1],current_top[0]}, 3'bxxx, 3'bxxx, 16'bxxxxxxxxxxxxxxxx, value_out, d_care_0);

    wire [15:0] new_top;
    mux_16 m0(current_top, incremented_address, decremented_address, current_top, pop, push, new_top);
	// mux to change the value of the read_write_addr
	// if pop and push are 0 0 then dont read or write therefore address doesnt change
	// if pop and push are 0 1 then write(push) therefore address is incremented by 1
	// if pop and push are 1 0 then read(pop) therefore address is decremented by 1
	// if pop and push are 1 1 then read(pop) and write(push) therefore address doesnt change

    reg_file rf1(clk, reset, 1'b1, 3'bxxx, 3'bxxx, 3'b000, new_top, d_care_0, d_care_1);
    reg_file rf7(clk, reset, push, 3'bxxx, 3'bxxx, {new_top[2],new_top[1],new_top[0]}, value_in, d_care_0, d_care_1);
endmodule