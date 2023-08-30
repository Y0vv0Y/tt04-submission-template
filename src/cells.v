/* 
This file provides the mapping from the Wokwi modules to Verilog HDL

It's only needed for Wokwi designs

*/

`timescale 1ns/10ps
module tt_um_mul_addtree(mul_a,mul_b,mul_out);
    input [3:0] mul_a,mul_b;          //IO端口声明
    output [7:0] mul_out;
    
    wire [7:0] mul_out;               //连线类型声明
    wire [7:0] store0,store1,store2,store3;
    wire [7:0] add01,add23;
    
    assign store0 = mul_b[0]?{4'b0000,mul_a}:8'b0000_0000;
    assign store1 = mul_b[1]?{3'b000,mul_a,1'b0}:8'b0000_0000;
    assign store2 = mul_b[2]?{2'b00,mul_a,2'b00}:8'b0000_0000;
    assign store3 = mul_b[3]?{1'b0,mul_a,3'b000}:8'b0000_0000;
    assign add01 = store0+store1;
    assign add23 = store2+store3;
    assign mul_out = add01+add23;
endmodule

//*****************testbench of mul_addtree******************
module mul_addtree_tb;
    wire [7:0] mul_out;               //输出是wire
    reg [3:0] mul_a;                  //输入是reg 
    reg [3:0] mul_b;
    
    //模块例化
    mul_addtree U(.mul_a(mul_a),.mul_b(mul_b),.mul_out(mul_out));
    
    //测试信号
    initial
        begin
            mul_a=4'b0;mul_b=4'b0;
            repeat(9)
                begin
                    #20 mul_a = mul_a+1'b1;mul_b = mul_b+1'b1;
                end
        end
endmodule

`define default_netname none

module buffer_cell (
    input clk,
    input ena,
    input rst_n, input [7:0] ui_in,
    input [7:0] uio_in,
    output [7:0] uio_oe,
    output [7:0] uio_out,
    output [7:0] uo_out,
    input wire in,
    output wire out
    );
    assign out = in;
endmodule

module and_cell (
    input wire a,
    input wire b,
    output wire out
    );

    assign out = a & b;
endmodule

module or_cell (
    input wire a,
    input wire b,
    output wire out
    );

    assign out = a | b;
endmodule

module xor_cell (
    input wire a,
    input wire b,
    output wire out
    );

    assign out = a ^ b;
endmodule

module nand_cell (
    input wire a,
    input wire b,
    output wire out
    );

    assign out = !(a&b);
endmodule

module not_cell (
    input wire in,
    output wire out
    );

    assign out = !in;
endmodule

module mux_cell (
    input wire a,
    input wire b,
    input wire sel,
    output wire out
    );

    assign out = sel ? b : a;
endmodule

module dff_cell (
    input wire clk,
    input wire d,
    output reg q,
    output wire notq
    );

    assign notq = !q;
    always @(posedge clk)
        q <= d;

endmodule

module dffsr_cell (
    input wire clk,
    input wire d,
    input wire s,
    input wire r,
    output reg q,
    output wire notq
    );

    assign notq = !q;

    always @(posedge clk or posedge s or posedge r) begin
        if (r)
            q <= 0;
        else if (s)
            q <= 1;
        else
            q <= d;
    end
endmodule
