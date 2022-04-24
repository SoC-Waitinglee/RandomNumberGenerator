`timescale 1ns/1ns
	module tb_Parity_Filter(
		);
		
		
		reg		high_Freq_Clk;
//		reg		low_Freq_Clk;
		reg 	reset;
		reg		button_Trig;
		
		wire	[7 : 0]  random_Byte;
		wire	test;
		wire	button_test;
		
		
		initial
			begin
				high_Freq_Clk = 1'b0;
//				low_Freq_Clk = 1'b0;
				reset = 1'b1;
				button_Trig = 1'b1;
			end
			
		always	#10 high_Freq_Clk = ~high_Freq_Clk;
//		always  #25 low_Freq_Clk = ~low_Freq_Clk;
		
		initial
			begin
				#100 reset = 1'b0;
				#100 reset = 1'b1;
				#100 button_Trig = 1'b0;
				#400 button_Trig = 1'b1;
			end
		parity_Filter_Top Top(
		.high_Freq_Clk(high_Freq_Clk),
//		.low_Freq_Clk(low_Freq_Clk),
		.reset(reset),
		.button_Trig(button_Trig),
		.random_Byte(random_Byte),
		.test(test),
		.button_test(button_test));
		
		endmodule