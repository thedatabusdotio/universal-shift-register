`timescale 1ns / 1ps
module universal_shift_register_tb();
parameter WIDTH=4;
parameter SIZE=3;

reg clk;
reg ce;
reg rst;
reg load;
reg dir;
reg [WIDTH-1:0] data_in;
reg [WIDTH*SIZE-1:0] din;
wire [WIDTH-1:0] data_out;
wire [WIDTH*SIZE-1:0] dout;

universal_shift_register #(WIDTH,SIZE) r1(clk,ce,rst,load,dir,data_in,din,data_out,dout);

initial begin
clk=0;
ce = 0;
rst = 0;
load = 0;
dir=0;
data_in=0;
din = 0;
#100;
rst = 1;
#50;
rst = 0;
#30;
ce = 1;
din = 12'habc;
#30;
load = 1;
#26;
load = 0;
#200;
din = 12'hdef;
dir=1;
#30;
load = 1;
#55;
load = 0;
end
always #(20) clk = ~clk;

endmodule
