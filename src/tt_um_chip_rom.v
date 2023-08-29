module tt_um_chip_rom (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);
    
    always@(posedge clk)
        if(reset)
            q <= 4'b0000;
    else if (q == 4'b1111)
        	q <= 4'b0000;
    else
        q <= q +1;
endmodule
