
	module			parity_Filter_Top(
		high_Freq_Clk,
		low_Freq_Clk,
		reset,
		button_Trig,
		
		tx_Done,
		
		valid_Sig,
		random_Byte);
		
		
		input			high_Freq_Clk;
		input           low_Freq_Clk;
		input			reset;
		input			button_Trig;
		
		input			tx_Done;
		
		output	[7 : 0] random_Byte;
		output			valid_Sig;
		// For test
		
		
		//wire		low_Freq_Clk;
		
		/*Sampler sampler(
		.clk(high_Freq_Clk),
		.reset(reset),
		
		.o_Sample_Clk(low_Freq_Clk));*/
		
		
		//Load Buttton Debounce Parameter //
		//parameter		DEBOUNCE_TIME = 25'b1001100010010110100000000;
		parameter		DEBOUNCE_TIME = 25'd5;
		
		// Load Button Debounce Register & Wire //
		reg		[24:0]	deb_Count;
		wire			En;
		// Button Debounce Trigger//			
		always@(posedge low_Freq_Clk or negedge reset)		
			begin
				if(~reset)
					deb_Count <= 25'b0;
				else if(button_Trig) begin
					if(deb_Count == DEBOUNCE_TIME - 1'b1)
						deb_Count <= DEBOUNCE_TIME - 1'b1;
					else
						deb_Count <= deb_Count + 1'b1;
				end
				else
					deb_Count <= 25'b0;
			end
			
		assign En = (deb_Count == DEBOUNCE_TIME - 1) ? 1'b1 : 1'b0;
		
		/*always@(posedge low_Freq_Clk or negedge reset)			// ?•œ ì£¼ê¸°ë§? HIGH?‹œ?‚¤ê¸? ?œ„?•œ Logic //
			begin
				if(~reset)
					deb_Count <= 1'b0;
				else if(button_Trig)
					deb_Count <= 1'b1;
				else
					deb_Count <= 1'b0;
			end
			
		assign random_On = deb_Count == 1'b1 ? 1'b1 : 1'b0; */
		
		
		wire		bit1, bit2, bit3, bit4, bit5, bit6, bit7;
		parity_Filter filter1(
		.high_Freq_Clk(high_Freq_Clk),
		.low_Freq_Clk(low_Freq_Clk),
		.reset(reset),
		
		.random_Bit(bit0));
		
		parity_Filter filter2(
		.high_Freq_Clk(high_Freq_Clk),
		.low_Freq_Clk(low_Freq_Clk),
		.reset(reset),
		
		.random_Bit(bit1));
		
		parity_Filter filter3(
		.high_Freq_Clk(high_Freq_Clk),
		.low_Freq_Clk(low_Freq_Clk),
		.reset(reset),
		
		.random_Bit(bit2));
		
		parity_Filter filter4(
		.high_Freq_Clk(high_Freq_Clk),
		.low_Freq_Clk(low_Freq_Clk),
		.reset(reset),
		
		.random_Bit(bit3));
		
		parity_Filter filter5(
		.high_Freq_Clk(high_Freq_Clk),
		.low_Freq_Clk(low_Freq_Clk),
		.reset(reset),
		
		.random_Bit(bit4));
		
		parity_Filter filter6(
		.high_Freq_Clk(high_Freq_Clk),
		.low_Freq_Clk(low_Freq_Clk),
		.reset(reset),
		
		.random_Bit(bit5));
		
		parity_Filter filter7(
		.high_Freq_Clk(high_Freq_Clk),
		.low_Freq_Clk(low_Freq_Clk),
		.reset(reset),
		
		.random_Bit(bit6));
		
		parity_Filter filter8(
		.high_Freq_Clk(high_Freq_Clk),
		.low_Freq_Clk(low_Freq_Clk),
		.reset(reset),
		
		.random_Bit(bit7));
		

		reg		[7 : 0]		r_Random_Byte;
		reg					r_Valid_Sig;
		always@(posedge low_Freq_Clk or negedge reset)
			begin
				if(~reset)
					begin
						r_Random_Byte <= 1'b0;
						r_Valid_Sig <= 1'b0;
					end
				else if(En && tx_Done)
					begin
						r_Random_Byte <= {bit7, bit6, bit5, bit4, bit3, bit2, bit1, bit0};
						r_Valid_Sig <= 1'b1;
					end
				else
					begin
						r_Random_Byte <= 1'b0;
						r_Valid_Sig <= 1'b0;
					end
			end
			
		assign	random_Byte = r_Random_Byte;
		assign	valid_Sig = r_Valid_Sig;
		
		endmodule