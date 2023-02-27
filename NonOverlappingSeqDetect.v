module fsm(rst_an,clk,d,out);
  input rst_an,clk,d;
  output reg out;
  parameter s1=3'b000 , s2 =3'b001 , s3=3'b010,s4=3'b011,s5=3'b100;
  reg [2:0]state,next;
  
  always @(posedge clk or negedge rst_an)
  begin
  if (!rst_an)
    state<=s1;
  else
    state<=next;
  end
  
  
always @(state or d)
begin
  next=3'bx;
  case(state)
    s1:begin
      if(d)
        next = s4;
      else
        next = s2;
      end
      
    s2:begin
      if(d)
        next = s4;
      else
        next = s3;
      end
      
    s3:begin 
      if(d)
        next=s4;
      else
        next = s2;
      end
    s4:begin
      if(d)
        next = s5;
      else
        next=s2;
      end
    s5:begin
      if(d)
        next = s4;
      else
        next=s2;
      end
    endcase
    
  end
  
always @(posedge clk or negedge rst_an)
  begin
    if(!rst_an)
      out=0;
    else
      case(next)
        s3:out=1;
        s5:out=1;
        default:out=0;
      endcase
    end
  endmodule

module fsmtb1;
	reg d,clk,rst_an;
	wire out;
	fsm t1(.rst_an(rst_an),.clk(clk),.d(d),.out(out));
	initial begin
	$monitor ($time,":Time \t d=%b rst_an=%b clk=%b\t out=%b",d,rst_an,clk,out);
	clk=0;
	rst_an=0;
	#10 rst_an =1;
	#20 d=1'b0;
	#40$display("\n\t\t\t 00 Sequence Detected\n");
	#40 $display("\n\t\t\tNon Overlapping Condition\n");
	#10  d=1'b1;
	#5 $display("\n\t\t\t   Data is 1 now\n");
	#70 $display("\n\t\t\t11 Sequence Detected\n");
	#40 $display("\n\t\t\tNon Overlapping Condition\n");
	end
	always 
	#20 clk=~clk;
endmodule
