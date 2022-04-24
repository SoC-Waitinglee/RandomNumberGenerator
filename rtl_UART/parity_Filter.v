
	module		parity_Filter(
		high_Freq_Clk,
		low_Freq_Clk,
		reset,
		
		random_Bit);
		
		
		input			high_Freq_Clk;
		input			low_Freq_Clk;
		input			reset;
		
		output	wire	random_Bit;

		wire			d1,d2,d3,d4;
		wire			sum1,sum2,sum3;
			
			
		RisingEdge_D_FF ff1(
		.clk(low_Freq_Clk),
		.reset(reset),
		.D(high_Freq_Clk),
		.Q(d1));
		
		RisingEdge_D_FF ff2(
		.clk(low_Freq_Clk),
		.reset(reset),
		.D(d1),
		.Q(d2));
		
		RisingEdge_D_FF ff3(
		.clk(low_Freq_Clk),
		.reset(reset),
		.D(d2),
		.Q(d3));
		
		RisingEdge_D_FF ff4(
		.clk(low_Freq_Clk),
		.reset(reset),
		.D(d3),
		.Q(d4));
		
		/*assign		sum1 = d1 + d2;
		assign		sum2 = d3 + d4;
		assign		sum3 = sum1 + sum2; */
		
		wire		d12 = d1 ^ d2;
		wire		d34 = d3 ^ d4;
		assign		random_Bit = d12 ^ d34;
		
		endmodule