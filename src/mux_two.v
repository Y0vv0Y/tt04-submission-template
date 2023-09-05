module tt_um_mux_two(out, a, b, sl, ui_in, uio_in, uio_oe, uio_out, uo_out, clk, ena, rst_n);
    input clk,ena,rst_n;
    input [7:0] ui_in, uio_in;
    output [7:0] uio_oe, uio_out;
    output [7:0] uo_out;
    input a, b, sl;
    output out;
    
    assign uio_oe = mul_b[0]?{4'b0000,mul_a}:8'b0000_0000;
    assign uio_out = mul_b[0]?{4'b0000,mul_a}:8'b0000_0000;
    
    wire nsl, sela, selb;
        assign nsl = ~sl;
        assign sela = a & nsl;
        assign selb = b & sl;
        assign out = sela | selb;	
endmodule


