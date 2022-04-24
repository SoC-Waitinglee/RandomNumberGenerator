`include "./uart_Define.v"
	module tb_Rng_Uart();
		
		
	reg		clk;
	reg		reset;
	
	reg		high_Freq_Clk;
	reg		low_Freq_Clk;
	
	reg		button;
	
	wire	tx;
		
		
	initial
		begin
			clk = 1'b0;
			reset = 1'b1;
			high_Freq_Clk = 1'b0;
			low_Freq_Clk = 1'b0;
			button = 1'b0;
		end
		
	initial
		begin
			#200 reset = 1'b0;
			#20 reset = 1'b1;
		end
	
	initial
		begin
			#1000 button = 1'b1;
		end
		
		
	always #5 clk = ~clk;
	always #26042.5 low_Freq_Clk = ~low_Freq_Clk;
	always #4340.25 high_Freq_Clk = ~high_Freq_Clk;
	
	
	rng_Uart_Top top(
		.sys_Clk(clk),
		.high_Freq_Clk(high_Freq_Clk),
		.low_Freq_Clk(low_Freq_Clk),
		.reset(reset),
		
		.button(button),
		
		.tx(tx));
		
	endmodule