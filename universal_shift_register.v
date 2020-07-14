`timescale 1ns / 1ps

module universal_shift_register #(parameter WIDTH = 8, parameter SIZE = 3) (
input clk,
input ce,
input rst,
input load,
input dir,                            
input [WIDTH-1:0] data_in,
input [WIDTH*SIZE-1:0] din,
output [WIDTH-1:0] data_out,
output [WIDTH*SIZE-1:0] dout
);
reg [WIDTH-1:0] sr [SIZE-1:0];
reg load_delayed;
reg load_pulse;
    

always@(posedge clk or posedge rst)
begin
   if(rst)
   begin
        load_delayed <= 0;
        load_pulse <= 0;
   end
   else
   begin
       load_delayed <= load;
       load_pulse <= load && ~load_delayed;
   end
    end

generate
genvar i;
for(i=0;i<SIZE;i=i+1)
begin:block
   always@(posedge clk or posedge rst)
    begin
       if(rst)
            begin
                sr[i] <= 'd0;
            end
        else if(ce)
          begin
              if(load_pulse)
              begin
                  sr[i] <= din[WIDTH*(i+1)-1:WIDTH*i];
              end
              else
              begin
              if(dir)
              begin
                if(i == SIZE-1)
                begin
                    sr[i] <= data_in;
                end
                else
                sr[i] <= sr[i+1];
              end
              else
              begin
                if(i == 'd0)
                begin
                      sr[i] <= data_in;
                end
                else
                begin
                    sr[i] <= sr[i-1];
                end
              end
              end
          end
        else
        begin
            sr[i] <= 'd0;
        end
    end
  assign dout[WIDTH*(i+1) - 1: WIDTH*i] = sr[i];
end
endgenerate
assign data_out = dir ? sr[0] : sr[SIZE-1];
endmodule