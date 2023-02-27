`timescale 1ns / 1ps

module VendingMachine(ticket,balance,coin,clk,rst);

//input,output and state definitions
input clk,rst;
input [1:0]coin;
output reg ticket,balance;
reg [1:0] state,next,next_ticket,next_balance;
parameter ZERO = 2'b00,
			 ONE = 2'b01,
    		 TWO = 2'b10;

always @(posedge clk or posedge rst) begin
	if(rst)
		state<=ZERO;
	else
		state<=next;
end

always @(state or coin) begin
	next = 2'bx;
	case(state)
		ZERO:case(coin)
			2'b00:begin
					next = ZERO;
					next_ticket = 0;
					next_balance = 0;
					end
			2'b01:begin
					next = ONE;
					next_ticket = 0;
					next_balance = 0;
					end
			2'b10:begin
					next = TWO;
					next_ticket = 0;
					next_balance = 0;
					end
	endcase
	
		ONE:case(coin)
			2'b00:begin
					next = ONE;
					next_ticket = 0;
					next_balance = 0;
					end
			2'b01:begin 
					next = TWO;
					next_ticket = 0;
					next_balance = 0;
					end
			2'b10:begin
					next = ZERO;
					next_ticket = 1;
					next_balance = 0;
					end
		endcase
		
		TWO:case(coin)
			2'b00:begin
					next = TWO;
					next_ticket = 0;
					next_balance = 0;
					end
			2'b01:begin
					next = ZERO;
					next_ticket = 1;
					next_balance = 0;
					end
			2'b10:begin
					next = ZERO;
					next_ticket = 1;
					next_balance = 1;
					end
			endcase
	endcase
end

always @(posedge clk or posedge rst) begin
	if(rst)
		begin
		ticket<=0;
		balance<=0;
		end
	else begin
		ticket<=next_ticket;
		balance<=next_balance;
		end
end

endmodule
