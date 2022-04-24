
	module	RisingEdge_D_FF(
		clk,
		reset,
		D,
		Q);
		
		
		input		clk;
		input		reset;
		
		input wire	D;
		output	reg	Q;
		
		always@(posedge clk or negedge reset)
			if(~reset)
				Q <= 1'b0;
			else
				Q <= D;
		
		
		endmodule