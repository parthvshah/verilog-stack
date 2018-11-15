module reg_3(input wire clk, reset, load, input wire [2:0] d, output wire [2:0] q);
    dfrl dl[2:0](clk, reset, load, d[2:0], q[2:0]);
endmodule

module mux2_3(input wire op, input wire [2:0] i0, i1, output wire [2:0] out);
    mux2 a0(i0[0],i1[0],op,out[0]);
    mux2 a1(i0[1],i1[1],op,out[1]);
    mux2 a2(i0[2],i1[2],op,out[2]);
endmodule

module stack(input wire clk, reset, push, pop, input wire [15:0] value_in, output wire [15:0] value_out);
    wire [2:0] top, inc_temp, dec_temp, inc_dec, inc, dec;
    wire carry_a, carry_s, is7, is0;
    wire push_or_pop;
    wire [15:0] d_care;

    or2 o0(push, pop, push_or_pop);

    fas3 a(top, 3'b001, 1'b0, inc, carry_a);
    fas3 b(top, 3'b001, 1'b1, dec, carry_s);

    // and3 a33(top[0],top[1],top[2], is7);
    // assign is7 = top==3'b111;
    // assign is0 = dec_temp==3'b000;

    // mux2 mx2(push, 1'b0, is7, push);
    // mux2_3 m23_0(is7, inc_temp, inc, inc);
    // mux2_3 m23_1(is0, dec_temp, dec, dec);
    
    mux2_3 m23_2(pop, inc, dec, inc_dec);

    reg_3 r3(clk, reset, push_or_pop, inc_dec, top);

    // module reg_file (input wire clk, reset, wr, input wire [2:0] rd_ addr_a, rd_addr_b, wr_addr, input wire [15:0] d_in, output wire [15:0] d_out_a, d_out_b);

    reg_file rf(clk, reset, push, top, 3'bxxx, top, value_in, value_out, d_care);
endmodule
