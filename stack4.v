module reg_3(input wire clk, reset, load, input wire [2:0] d, output wire [2:0] q);
    dfrl dl[2:0](clk, reset, load, d[2:0], q[2:0]);
endmodule

module regr_1(input wire clk, reset, input wire d, output wire q);
    dfr dl(clk, reset, d, q);
endmodule

module regs_1(input wire clk, set, input wire d, output wire q);
    dfs dl(clk, set, d, q);
endmodule

module mux2_3(input wire op, input wire [2:0] i0, i1, output wire [2:0] out);
    mux2 a0(i0[0],i1[0],op,out[0]);
    mux2 a1(i0[1],i1[1],op,out[1]);
    mux2 a2(i0[2],i1[2],op,out[2]);
endmodule

module mux4_3(input wire op2, op1, input wire [2:0] i0, i1, i2, i3, output wire [2:0] out);
    mux4 a0({i0[0],i1[0],i2[0],i3[0]},op2,op1,out[0]);
    mux4 a1({i0[1],i1[1],i2[1],i3[1]},op2,op1,out[1]);
    mux4 a2({i0[2],i1[2],i2[2],i3[2]},op2,op1,out[2]);
endmodule


module stack(input wire clk, reset, push, pop, input wire [15:0] value_in, output wire [15:0] value_out, output wire full, empty);
    wire is_7, is_7_reg, is_0, is_0_reg, write_push, write_pop, top_write_enable, carry_a, carry_s;
    wire [2:0] top, inc, dec, inc_dec;
    wire [15:0] d_care;
    regr_1 reg1(clk, reset, is_7, is_7_reg);
    mux2 push_checker(push, 1'b0, is_7_reg, write_push);

    regs_1 reg2(clk, reset, is_0, is_0_reg);
    mux2 pop_checker(pop, 1'b0, is_0_reg, write_pop);

    or2 top_reg_writer(write_pop, write_push, top_write_enable);
    reg_3 top_reg(clk, reset, top_write_enable, inc_dec, top);
    
    fas3 a(top, 3'b001, 1'b0, inc, carry_a);
    fas3 b(top, 3'b001, 1'b1, dec, carry_s);
    mux4_3 top_changer(write_pop, write_push, top, dec, inc, top, inc_dec);

    reg_file rf(clk, reset, write_push, top, 3'bxxx, top, value_in, value_out, d_care);
    and3 full_checker(inc_dec[2], inc_dec[1], inc_dec[0], is_7);
    and3 empty_checker((!inc_dec[2]), (!inc_dec[1]), (!inc_dec[0]), is_0);
    assign full = is_7;
    assign empty = is_0;
endmodule
