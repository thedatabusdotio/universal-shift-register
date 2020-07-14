`timescale 1ns / 1ps

module variable_shift_register_tb();
parameter WIDTH=4,SIZE=3;
reg clk;                              //clock
reg ce;                              //clock enable                        
reg rst;                              //reset
reg [WIDTH-1:0] din;                  //data in
wire [WIDTH-1:0] dout;                 //data out

variable_shift_register #(WIDTH,SIZE) r1 (clk,ce,rst,din,dout);

initial begin
clk = 0;
ce = 0;
rst = 0;
din = 0;
#100;
rst = 1;
#15;
rst = 0;
ce = 1;
din = 4'ha;
#40;
din = 4'hb;
#40;
din = 4'hc;
#40;
din = 4'hd;
#40;
din = 4'he;

end
always #(20) clk = ~clk;
endmodule
