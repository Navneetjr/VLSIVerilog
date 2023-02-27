module  TrafficLight(red,yellow,green,clk,rst_an);
input rst_an,clk;
output reg red, green, yellow;
parameter RED=2'b00, YELLOW=2'b01, GREEN = 2'b10;
reg [1:0]present,next;
reg change;
always @(posedge clk or negedge rst_an)
begin
if(!rst_an)
begin
change=0;
present<=RED;
end
else
begin
present<=next;
change<=~change;
end
end

always @(present or change)
begin
//$display("\n\t\t\t\tChange of Light\n");
next = 2'bx;
case (present)
	RED:if(!rst_an)
		next=RED;
		else
		begin
		next=GREEN;
		change=~change;
		end
	YELLOW:begin
		next=RED;
		change=~change;
		end
	GREEN:begin 
		next= YELLOW;
		change=~change;
		end		
endcase
end

always @(present)
case(present)
	RED:	begin
		red=1;
		green=0;
		yellow=0;
		end
	GREEN:begin 
		green=1;
		red=0;
		yellow=0;		
		end	
	YELLOW: begin
			yellow =1;
			red=0;
			green=0;
		end
	default:begin
			red=0;
			green=0;
			yellow=0;
			end

endcase

endmodule

module trafficlighttb;
reg clk,rst_an;
wire red,green,yellow;
TrafficLight t(red,yellow,green,clk,rst_an);
initial begin
$monitor ($time,":Time \t RED=%b YELLOW=%b GREEN=%b\tclk=%b",red,yellow,green,clk);

clk=0;
rst_an=0;
#10 rst_an =1;
end
always 
begin
#50 clk=~clk;
if(clk==1)
$display("\n\t\t\t\tChange of Light\n");
end
endmodule

