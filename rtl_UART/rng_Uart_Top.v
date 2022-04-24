
	module		rng_Uart_Top(
		sys_Clk,
		high_Freq_Clk,
		low_Freq_Clk,
		reset,
		
		button,
		
		tx);
		
		input			sys_Clk;
		input			high_Freq_Clk;
		input			low_Freq_Clk;
		input			reset;
		
		input			button;
		
		output			tx;
		
		
		wire		[7 : 0]		random_Byte;
		wire					tx_Start;
		wire					tx_Done;
		uart_Top uart(
		.clk(sys_Clk),
		.reset(reset),
		
		.rx(),
		.test_Data(random_Byte),
		.button_Trig(),
		.wr_Sig(tx_Start),
		
		.tx(tx),
		.tx_Done(tx_Done),
		.sig_Empty(),
		.sig_Full());
		
		parity_Filter_Top parity(
		.high_Freq_Clk(high_Freq_Clk),
		.low_Freq_Clk(low_Freq_Clk),
		.reset(reset),
		.button_Trig(button),
		
		.tx_Done(tx_Done),
		
		.valid_Sig(tx_Start),
		.random_Byte(random_Byte));
		
		endmodule