module fa(input wire a,b,c, output wire sum, carry);
    wire t0,t1,t2;
    xor3 a0(a,b,c,sum);
    and2 a1(a,b,t0);
    and2 a2(b,c,t1);
    and2 a3(c,a,t2);
    or3 a4(t0,t1,t2,carry);
endmodule

module fas16(input wire [15:0] a,b, input wire cin, output wire [15:0] sum, output wire carry);
    wire [15:0] bxor,t;
    xor2 a0[15:0](b[15:0],cin,bxor[15:0]);

    fa b0(a[0],bxor[0],cin,sum[0],t[0]);
    fa b1(a[1],bxor[1],t[0],sum[1],t[1]);
    fa b2(a[2],bxor[2],t[1],sum[2],t[2]);
    fa b3(a[3],bxor[3],t[2],sum[3],t[3]);
    fa b4(a[4],bxor[4],t[3],sum[4],t[4]);
    fa b5(a[5],bxor[5],t[4],sum[5],t[5]);
    fa b6(a[6],bxor[6],t[5],sum[6],t[6]);
    fa b7(a[7],bxor[7],t[6],sum[7],t[7]);
    fa b8(a[8],bxor[8],t[7],sum[8],t[8]);
    fa b9(a[9],bxor[9],t[8],sum[9],t[9]);
    fa b10(a[10],bxor[10],t[9],sum[10],t[10]);
    fa b11(a[11],bxor[11],t[10],sum[11],t[11]);
    fa b12(a[12],bxor[12],t[11],sum[12],t[12]);
    fa b13(a[13],bxor[13],t[12],sum[13],t[13]);
    fa b14(a[14],bxor[14],t[13],sum[14],t[14]);
    fa b15(a[15],bxor[15],t[14],sum[15],carry);
endmodule

module fas3(input wire [2:0] a,b, input wire cin, output wire [2:0] sum, output wire carry);
    wire [2:0] bxor,t;
    xor2 a0[2:0](b[2:0],cin,bxor[2:0]);

    fa b0(a[0],bxor[0],cin,sum[0],t[0]);
    fa b1(a[1],bxor[1],t[0],sum[1],t[1]);
    fa b2(a[2],bxor[2],t[1],sum[2],carry);
endmodule

module bitand(input wire [15:0] a,b, output wire [15:0] c);
    and2 a0[15:0](a[15:0],b[15:0],c[15:0]);
endmodule

module bitor(input wire [15:0] a,b, output wire [15:0] c);
    or2 a0[15:0](a[15:0],b[15:0],c[15:0]);
endmodule

module alu(input wire [1:0] op, input wire [15:0] i0, i1, output wire [15:0] o, output wire cout);
    wire [15:0] t0, t1, t2, t3;
    wire zero, one;
    assign zero = 1'b0;
    assign one = 1'b1;    
    wire carry0, carry1;

    fas16 b(i0[15:0], i1[15:0], zero, t0[15:0], carry0);
    fas16 c(i0[15:0], i1[15:0], one, t1[15:0], carry1);
    bitand d(i0[15:0], i1[15:0], t2[15:0]);
    bitor e(i0[15:0], i1[15:0], t3[15:0]);

    mux4 a0({t0[0],t1[0],t2[0],t3[0]},op[0],op[1],o[0]);
    mux4 a1({t0[1],t1[1],t2[1],t3[1]},op[0],op[1],o[1]);
    mux4 a2({t0[2],t1[2],t2[2],t3[2]},op[0],op[1],o[2]);
    mux4 a3({t0[3],t1[3],t2[3],t3[3]},op[0],op[1],o[3]);
    mux4 a4({t0[4],t1[4],t2[4],t3[4]},op[0],op[1],o[4]);
    mux4 a5({t0[5],t1[5],t2[5],t3[5]},op[0],op[1],o[5]);
    mux4 a6({t0[6],t1[6],t2[6],t3[6]},op[0],op[1],o[6]);
    mux4 a7({t0[7],t1[7],t2[7],t3[7]},op[0],op[1],o[7]);
    mux4 a8({t0[8],t1[8],t2[8],t3[8]},op[0],op[1],o[8]);
    mux4 a9({t0[9],t1[9],t2[9],t3[9]},op[0],op[1],o[9]);
    mux4 a10({t0[10],t1[10],t2[10],t3[10]},op[0],op[1],o[10]);
    mux4 a11({t0[11],t1[11],t2[11],t3[11]},op[0],op[1],o[11]);
    mux4 a12({t0[12],t1[12],t2[12],t3[12]},op[0],op[1],o[12]);
    mux4 a13({t0[13],t1[13],t2[13],t3[13]},op[0],op[1],o[13]);
    mux4 a14({t0[14],t1[14],t2[14],t3[14]},op[0],op[1],o[14]);
    mux4 a15({t0[15],t1[15],t2[15],t3[15]},op[0],op[1],o[15]);

    mux2 f(carry0,carry1,op[1],cout);
endmodule