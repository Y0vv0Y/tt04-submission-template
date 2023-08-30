// Copyright 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

`timescale 1ns/10ps
module tt_um_mul_addtree(mul_a,mul_b, ui_in, uio_in, uio_oe, uio_out, uo_out, clk);
    input clk;
    input [7:0] ui_in, uio_in;
    output [7:0] uio_oe, uio_out;
    input [3:0] mul_a,mul_b;          //IO端口声明
    output [7:0] uo_out;
    
    wire [7:0] uo_out;               //连线类型声明
    wire [7:0] store0,store1,store2,store3;
    wire [7:0] add01,add23;
    
    assign store0 = mul_b[0]?{4'b0000,mul_a}:8'b0000_0000;
    assign store1 = mul_b[1]?{3'b000,mul_a,1'b0}:8'b0000_0000;
    assign store2 = mul_b[2]?{2'b00,mul_a,2'b00}:8'b0000_0000;
    assign store3 = mul_b[3]?{1'b0,mul_a,3'b000}:8'b0000_0000;
    assign add01 = store0+store1;
    assign add23 = store2+store3;
    assign uo_out = add01+add23;
endmodule

//*****************testbench of mul_addtree******************
module mul_addtree_tb;
    wire [7:0] uo_out;               //输出是wire
    reg [3:0] mul_a;                  //输入是reg 
    reg [3:0] mul_b;
    
    //模块例化
    mul_addtree U(.mul_a(mul_a),.mul_b(mul_b),.uo_out(uo_out));
    
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

/*module tt_um_chip_rom(clk, rst_n, ena, x, y, p, ui_in, uio_in, uio_oe, uio_out, uo_out);
    parameter size = 32;
    input clk, rst_n, ena;
    input y;
    input[size-1:0] x;
    output p;
    input [7:0] ui_in, uio_in;
    output [7:0] uio_oe, uio_out, uo_out;

    wire[size-1:1] pp;
    wire[size-1:0] xy;

    genvar i;

	CSADD csa0 (.clk(clk), .rst_n(rst_n), .x(x[0]&y), .y(pp[1]), .sum(p));
    generate for(i=1; i<size-1; i=i+1) begin
        CSADD csa (.clk(clk), .rst_n(rst_n), .x(x[i]&y), .y(pp[i+1]), .sum(pp[i]));
    end endgenerate
    TCMP tcmp (.clk(clk), .rst_n(rst_n), .a(x[size-1]&y), .s(pp[size-1]));

endmodule

module TCMP(clk, rst_n, a, s);
    input clk, rst_n;
    input a;
    output reg s;

    reg z;

    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
            //Reset logic goes here.
            s <= 1'b0;
            z <= 1'b0;
        end
        else begin
            //Sequential logic goes here.
            z <= a | z;
            s <= a ^ z;
        end
    end
endmodule

module CSADD(clk, rst_n, x, y, sum);
    input clk, rst_n;
    input x, y;
    output reg sum;

    reg sc;

    // Half Adders logic
    wire hsum1, hco1;
    assign hsum1 = y ^ sc;
    assign hco1 = y & sc;

    wire hsum2, hco2;
    assign hsum2 = x ^ hsum1;
    assign hco2 = x & hsum1;

    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
            //Reset logic goes here.
            sum <= 1'b0;
            sc <= 1'b0;
        end
        else begin
            //Sequential logic goes here.
            sum <= hsum2;
            sc <= hco1 ^ hco2;
        end
    end
endmodule*/


/*

module spm_tb;

	//Inputs
	reg clk;
	reg rst;
	reg [7: 0] x;

    reg[7:0] Y;
    reg[15:0] P;

	//Outputs
	wire p;

    reg[3:0] cnt;

	//Instantiation of Unit Under Test
	spm #(8) uut (
		.clk(clk),
		.rst(rst),
		.y(Y[0]),
		.x(x),
		.p(p)
	);

    always #5 clk = ~clk;

    always @ (posedge clk)
        if(rst) Y = -50;
        else Y <= {1'b0,Y[7:1]};

    always @ (posedge clk)
        if(rst) P = 0;
        else P <= {p, P[15:1]};

	always @ (posedge clk)
        if(rst) cnt = 0;
        else cnt <= cnt + 1;

	initial begin
	//Inputs initialization
		clk = 0;
		rst = 0;
		x = 50;

	//Reset
		#20 rst = 1;
		#20 rst = 0;
        #1000;
        $finish;
	end

endmodule
*/

