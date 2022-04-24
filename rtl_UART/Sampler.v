	//Input clk = 100Mhz(Period : 10ns)
	//Output sample_Clk = 40MHz
	
	module	Sampler(
		clk,
		reset,
		
		o_Sample_Clk);
		
		
		input			clk;
		input			reset;
		
		output			o_Sample_Clk;
		
		
		parameter		UBRR = 2;
		parameter		UBRR_BIT = 2;
		
		reg		[UBRR_BIT - 1 : 0]			clk_Sample;
		reg									sample_Reg;
		
		// clk_Sample
		always@(posedge clk or negedge reset)
			begin
				if(~reset)
					begin
						clk_Sample <= 1'b0;
						sample_Reg <= 1'b0;
					end
				else
					if(clk_Sample == UBRR - 1)
						begin
							clk_Sample <= 1'b0;
							sample_Reg <= ~sample_Reg;
						end
					else
						begin
							clk_Sample <= clk_Sample + 1'b1;
							sample_Reg <= sample_Reg;
						end
			end
		
		assign		o_Sample_Clk = sample_Reg;
		endmodule
		
		
		