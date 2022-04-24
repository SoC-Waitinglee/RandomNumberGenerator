`include "./uart_Define.v"

	module		uart_Onebyte_Buffer(
		sample_Clk,
		resetn,
		
		wr_Sig,
		test_Data,
		
		tx_Data,
		tx_Start);
		
		parameter		BUFFER_WIDTH = 8;
		
		input			sample_Clk;
		input			resetn;
		
		input			wr_Sig;
		input	[BUFFER_WIDTH-1 : 0] test_Data;
		
		output	[BUFFER_WIDTH-1 : 0] tx_Data;
		output			tx_Start;
		
		reg			[BUFFER_WIDTH-1 : 0]		tx_Buf;
		reg						r_Wr_Sig;
		always@(posedge sample_Clk or negedge resetn)
			begin
				if(~resetn)
					begin
						tx_Buf <= 1'b0;
						r_Wr_Sig <= 1'b0;
					end
				else if(wr_Sig)
					begin
						tx_Buf <= test_Data;
						r_Wr_Sig <= 1'b1;
					end
				else
					begin
						tx_Buf <= 1'b0;
						r_Wr_Sig <= 1'b0;
					end
			end
			
	assign		tx_Data = tx_Buf;
	assign		tx_Start = r_Wr_Sig;
	
	endmodule