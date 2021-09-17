module shiftreg
	#(
		parameter NB_LEDS = 4
	)
	(
	output	[NB_LEDS-1:0] 	o_led,
	input					i_valid,
	input					i_reset,
	input 					clock
);
	
	reg [NB_LEDS -1 :0]	shitfregister;
	
	always @(posedge clock) begin
		if(i_reset) begin
			shitfregister <= {{(NB_LEDS-2){1'b0}},1'b1};
		end
		else if(i_valid) begin
			//shifregister <= shiftregister << 1;
			//shitregister[0] <= shiftregister[NB_LEDS-1];
			shitfregister <= {shitfregister[NB_LEDS-2:0],shitfregister[NB_LEDS-1]};
		end
		else begin
			shitfregister <= shitfregister;
		end
	end
	
	assign o_led = shitfregister;
	
endmodule