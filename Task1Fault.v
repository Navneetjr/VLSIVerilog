module FaultFree(A,B,C,D,Y1,Y2);
  input    A,B,C,D;
  output   Y1,Y2;
  wire     w1,w2,w4,w5,w6,w7,w8,w9;    
  nand(w1,A,B);
  or(w2,C,D);
  nand(w6,w1,w2);
  or(w5,w2,D);
  not(w4,w6);
  not(w7,A);
  xor(w9,w4,w5);
  or(w8,w5,w6);
  nor(Y1,w7,w8,w5);
  nand(Y2,w8,w9,w2);
endmodule // FaultFree

module Fault_1(A,B,C,D, fu11, fu21);
  input    A,B,C,D;
  output   fu11,fu21;
  wire     w1,w2,w3,w4,w5,w6,w7,w8,w9;    
  nand(w1,A,B);
  or(w2,C,D);
  or(w3,w4,1);
  nand(w6,w1,w2);
  or(w5,w2,D);
  not(w4,w6);
  not(w7,A);
  xor(w9,w3,w5);
  or(w8,w5,w6);
  nor(fu11,w7,w8,w5);
  nand(fu21,w8,w9,w2);
endmodule // Fault_1 stuck at 1
                      
module Fault_2(A,B,C,D, fu12,fu22);
  input    A,B,C,D;
  output   fu12,fu22;
  wire     w1,w2,w3,w4,w5,w6,w7,w8,w9;    
  nand(w1,A,B);
  or(w2,C,D);
  and(w3,w1,0);
  nand(w6,w3,w2);
  or(w5,w3,D);
  not(w4,w6);
  not(w7,A);
  xor(w9,w4,w5);
  or(w8,w5,w6);
  nor(fu12,w7,w8,w5);
  nand(fu22,w8,w9,w2);
endmodule // Fault_2 stuck at 0   

module Fault_3(A,B,C,D,fu13,fu23);
  input    A,B,C,D;
  output   fu13,fu23;
  wire     w1,w2,w3,w4,w5,w6,w7,w8,w9;    
  nand(w1,A,B);
  or(w2,C,D);
  nand(w6,w1,w2);
  or(w5,w3,D);
  and(w3,w5,0);
  not(w4,w6);
  not(w7,A);
  xor(w9,w4,w3);
  or(w8,w3,w6);
  nor(fu13,w7,w8,w5);
  nand(fu23,w8,w9,w2);
endmodule // Fault_3 stuck at 0          

module Fault_4(A,B,C,D,fu14,fu24);
  input    A,B,C,D;
  output   fu14,fu24;
  wire     w1,w2,w4,w5,w6,w7,w8,w9;    
  nand(w1,A,B);
  or(w2,C,D);
  nand(w6,w1,w2);
  or(w5,w2,D);
  not(w4,w6);
  not(w7,A);
  or(w3,w7,1);
  xor(w9,w4,w5);
  or(w8,w5,w6);
  nor(fu14,w3,w8,w5);
  nand(fu24,w8,w9,w2);
endmodule // Fault_4 stuck at 1        

module Fault_5(A,B,C,D,fu15,fu25);
  input    A,B,C,D;
  output   fu15,fu25;
  wire     w1,w2,w3,w4,w5,w6,w7,w8,w9;    
  nand(w1,A,B);
  or(w2,C,D);
  nand(w6,w1,w2);
  or(w5,w2,D);
  not(w4,w6);
  not(w7,A);
  xor(w9,w4,w5);
  or(w8,w5,w6); 
  and(w3,w8,0);
  nor(fu15,w7,w3,w5);
  nand(fu25,w8,w9,w2);
endmodule // Fault_5 stuck at 0   
                                   
module Fault_6(A,B,C,D,fu16,fu26);
  input    A,B,C,D;
  output   fu16,fu26;
  wire     w1,w2,w3,w4,w5,w6,w7,w8,w9;    
  nand(w1,A,B);
  or(w2,C,D);
  nand(w6,w1,w2);
  or(w5,w2,D);
  not(w4,w6);
  not(w7,A);
  xor(w9,w4,w5);
  or(w8,w5,w6);
  nor(fu16,w7,w8,w5);
  or(w3,w2,1);
  nand(fu26,w8,w9,w3);
endmodule // Fault_6 stuck at 1


module faulttb;
	reg A,B,C,D;
	wire Y1,Y2,fu11,fu21,fu12,fu22,fu13,fu23,fu14,fu24,fu15,fu25,fu16,fu26;  
	integer i,Max_TV;
	reg [3:0]count;
	reg [79:0]f1,f2,f3,f4,f5,f6;
  
	FaultFree ff(A,B,C,D,Y1,Y2);
	Fault_1 f11(A,B,C,D,fu11,fu21);
	Fault_2 f22(A,B,C,D,fu12,fu22);
	Fault_3 f33(A,B,C,D,fu13,fu23);                                             
	Fault_4 f44(A,B,C,D,fu14,fu24);
	Fault_5 f55(A,B,C,D,fu15,fu25);
	Fault_6 f66(A,B,C,D,fu16,fu26);

	initial 
	begin
	Max_TV=0;
    for(i=0;i<=15;i=i+1)
    begin
 		#5 {A,B,C,D}=i;
 		#5 count =3'b0; 
 		if(Y1^fu11 || Y2^fu21)
 		f1="Detected";
 		else
 		f1="Undetected";
 		if(Y1^fu12 || Y2^fu22)
 		f2="Detected";
 		else
 		f2="Undetected";
 		if(Y1^fu13 || Y2^fu23)
 		f3="Detected";
 		else
 		f3="Undetected";
 		if(Y1^fu14 || Y2^fu24)
 		f4="Detected";
 		else
 		f4="Undetected";
 		if(Y1^fu15 || Y2^fu25)
 		f5="Detected";
 		else
 		f5="Undetected";
 		if(Y1^fu16 || Y2^fu26)
 		f6="Detected";
 		else
 		f6="Undetected";          
 		count= (Y1^fu11 || Y2^fu21)+(Y1^fu12 || Y2^fu22)+(Y1^fu13 || Y2^fu23)+(Y1^fu14 || Y2^fu24)+(Y1^fu15 || Y2^fu25)+(Y1^fu16 || Y2^fu26);
 		if(count>=Max_TV)
 		begin
 			Max_TV=i;
 		end
 		$display("__________________________________________________________________________________________________________________________________________________________________________________");
 		//$display("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
 		$display("\n\t\t\t Testvector:%b%b%b%b\t\t\t\t\t\t Outputs=>Y1=%b Y2=%b--FU11=%b FU21=%b--FU12=%b FU22=%b--FU13=%b FU23=%b--FU14=%b FU24=%b--FU15=%b FU25=%b--FU16=%b FU26=%b",A,B,C,D,Y1,Y2,fu11,fu21,fu12,fu22,fu13,fu23,fu14,fu24,fu15,fu25,fu16,fu26);
 		$display("\n\t\t\t\t\tF1 %s\t||\tF2 %s\t||\tF3 %s\t||\tF4 %s\t||\tF5 %s\t||\tF6 %s\t||\t\tTotal Count=%d",f1,f2,f3,f4,f5,f6,count);
 		
 
 		//$display($time,"\tA=%b B=%b C=%b D=%b Y1=%b Y2=%b FU11=%b FU21=%b FU12=%b FU22=%b FU13=%b FU23=%b FU14=%b FU24=%b FU15=%b FU25=%b FU16=%b FU26=%b",A,B,C,D,Y1,Y2,fu11,fu21,fu12,fu22,fu13,fu23,fu14,fu24,fu15,fu25,fu16,fu26);
 		
		   
    end 
    $display("\nMaximum faults are found by Test Vector:%b",Max_TV[3:0]);     
   	$display("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
    //$display("__________________________________________________________________________________________________________________________________________________________________________________");              
    $display("\n\tSorting on the basis of Faults"); 
    $display("\n\tFault 1");
    #5 count=0;
    for(i=0;i<=15;i=i+1)
    begin
       #5{A,B,C,D}=i;
       #5 
       if(Y1^fu11 || Y2^fu21)
       begin
          $display("\n\t\t%b%b%b%b",A,B,C,D);
          count=count+1;   
       end 
    end        
    if(count!=0)
    $display("\n\t Total Count=%d",count);
    else 
    $display("\n\t Undetected");  
    	$display("__________________________________________________________________________________________________________________________________________________________________________________");
	
	    $display("\n\tFault 2");
    #5 count=0;
    for(i=0;i<=15;i=i+1)
    begin
       #5{A,B,C,D}=i;
       #5 
       if(Y1^fu12 || Y2^fu22)
       begin
          $display("\n\t\t%b%b%b%b",A,B,C,D);
          count=count+1;   
       end 
    end        
    if(count!=0)
    $display("\n\t Total Count=%d",count);
    else 
    $display("\n\t Undetected");
    	$display("__________________________________________________________________________________________________________________________________________________________________________________");
		    $display("\n\tFault 3");
    #5 count=0;
    for(i=0;i<=15;i=i+1)
    begin
       #5{A,B,C,D}=i;
       #5 
       if(Y1^fu13 || Y2^fu23)
       begin
          $display("\n\t\t%b%b%b%b",A,B,C,D);
          count=count+1;   
       end 
    end        
    if(count!=0)
    $display("\n\t Total Count=%d",count);
    else 
    $display("\n\t Undetected");   
    
    	$display("__________________________________________________________________________________________________________________________________________________________________________________");
	
		    $display("\n\tFault 4");
    #5 count=0;
    for(i=0;i<=15;i=i+1)
    begin
       #5{A,B,C,D}=i;
       #5 
       if(Y1^fu14 || Y2^fu24)
       begin
          $display("\n\t\t%b%b%b%b",A,B,C,D);
          count=count+1;   
       end 
    end        
    if(count!=0)
    $display("\n\t Total Count=%d",count);
    else 
    $display("\n\t Undetected");
	
		$display("__________________________________________________________________________________________________________________________________________________________________________________");
		    $display("\n\tFault 5");
    #5 count=0;
    for(i=0;i<=15;i=i+1)
    begin
       #5{A,B,C,D}=i;
       #5 
       if(Y1^fu15 || Y2^fu25)
       begin
          $display("\n\t\t%b%b%b%b",A,B,C,D);
          count=count+1;     
       end 
    end        
    if(count!=0)
    $display("\n\t Total Count=%d",count);
    else 
    $display("\n\t Undetected");       
    
    	$display("__________________________________________________________________________________________________________________________________________________________________________________");
	
    	    $display("\n\tFault 6");
    #5 count=0;
    for(i=0;i<=15;i=i+1)
    begin
       #5{A,B,C,D}=i;
       #5 
       if(Y1^fu16 || Y2^fu26)
       begin
          $display("\n\t\t%b%b%b%b",A,B,C,D);
          count=count+1;   
       end 
    end        
    if(count!=0)
    $display("\n\t Total Count=%d",count);
    else 
    $display("\n\t Undetected");
	
	
	
	end
	
	    
		
endmodule