`timescale 1ms / 1ns

module RtClk(HH,mm,ss,clk,rst,settime);
output reg [5:0]ss,mm;
output reg [4:0]HH;
input clk,rst;
input [17:0]settime;

always @(posedge clk or posedge rst) begin
if(rst)
	{HH,mm,ss}<=17'b0;
else if(settime) 
	{HH,mm,ss}<=settime;
else
	if(ss<6'd59)
		ss<=ss+1;
	else begin
		ss<=0;
		mm<=mm+1;
		if(mm<6'd59)
			mm<=mm+1;
		else begin
			mm<=0;
			HH<=HH+1;
			if(HH<5'd23)
				HH<=HH+1;
			else
				HH<=0;
			ss<=6'b0;
		end
	end
end
endmodule


module rtclk_tb;

reg clk;
reg rst;
reg [17:0] settime;

wire [4:0] HH;
wire [5:0] mm;
wire [5:0] ss;

RtClk uut (.HH(HH),.mm(mm),.ss(ss),.clk(clk),.rst(rst),.settime(settime));
always #500 clk=~clk;
initial begin
$monitor("#%0d => Current Time = %2d hours %2d minutes %2dseconds",$time,HH,mm,ss);
clk = 0;
rst = 1;
settime = 0;
#1000;
rst = 0;
settime = 7'b10111111010011110;
#1000;
settime = 0;
rst = 0;
#1000;
end

endmodule
