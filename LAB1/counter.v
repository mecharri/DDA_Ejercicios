module counter 
	#(
		parameter NB_SW = 3,
		parameter NB_COUNT = 32
	)
	(
		output				o_valid,
		input [NB_SW-1:0]	i_sw,
		input				i_reset,
		input				clock
	);
	
	localparam R0 = (2**(NB_COUNT-10))-1;
	localparam R1 = (2**(NB_COUNT-9)) -1;
	localparam R2 = (2**(NB_COUNT-8)) -1;
	localparam R3 = (2**(NB_COUNT-7)) -1;
	
	wire [NB_COUNT-1 : 0]	limit_ref;
	reg [NB_COUNT:0]  		counter;
	reg 					valid;
	
	
	assign limit_ref = (i_sw[2:1] == 2'b00)? R0 :
		(i_sw[2:1] == 2'b01)? R1 :
		(i_sw[2:1] == 2'b10)? R2 : R3;
	
	
	/*
	//Tiene de problema que no toma el NB_SW
	always @(*) begin
		case (i_sw[2:1])
			2'b00:		limit_ref = R0;
			2'b01:		limit_ref = R1;
			2'b10:		limit_ref = R2;
			default:	limit_ref = R3;
		endcase
	end
	*/
	
	
	//Lo inteto hacer con el case parametrizable:
	/*always @(*) begin
		case (i_sw[NB_SW-1:NB_REF-2])
			2'b00:		limit_ref = R0;
			2'b01:		limit_ref = R1;
			2'b10:		limit_ref = R2;
			default:	limit_ref = R3;
		endcase
	end*/
	
	always @(posedge clock) begin
		if(i_reset) begin
			counter <= {NB_COUNT {1'b0}};//0;
			valid <= 1'b0;
		end
		else if(i_sw[0]) begin
			if(counter >= limit_ref) begin
				counter <= {NB_COUNT {1'b0}};//0
				valid <= 1'b1;
			end
			else begin
				counter <= counter + {{NB_COUNT-1 {1'b0}}, 1'b1};
				valid <= 1'b0;
			end
		end
		else begin
			counter <= counter;
			valid <= 1'b0;//Se pone cero y no valid porque si llega a quedar en 1 el valid se queda mandando un 1
		end
		
	end
	
	assign o_valid = valid;
	
endmodule