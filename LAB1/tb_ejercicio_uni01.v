//Definiciones

`define NB_LEDS 4
`define NB_SEL 2
`define NB_COUNT 14
`define NB_SW 4

`timescale 1ns/100ps

module tb_ejercicio_uni01();

//Parámetros
parameter NB_LEDS   = `NB_LEDS  ;
parameter NB_SEL    = `NB_SEL  ;
parameter NB_COUNT  = `NB_COUNT;
parameter NB_SW     = `NB_SW   ;

wire [NB_LEDS-1:0]  o_led;//Led
wire [NB_LEDS-1:0]  o_led_b;//Led azul
wire [NB_LEDS-1:0]  o_led_g;//Led verde

reg [NB_LEDS-1:0]   i_sw;//Switchs
reg                 i_reset;//Reset
reg                 clock;//Clock del sistema

wire [NB_COUNT-1 : 0]   tb_count; //Acá voy a meter la cuenta interna del contador

assign tb_count = tb_ejercicio_uni01.u_shift_leds.u_counter.counter;

initial begin: stimulus
      i_sw[0]      = 1'b0  ;
      clock        = 1'b0  ;
      i_reset      = 1'b0  ;
      i_sw[2:1]    = `NB_SEL'h0 ;
      i_sw[3]      = 1'b0  ;
      #100 i_reset = 1'b1  ;
      #100 i_sw[0] = 1'b1  ;

      #1000000 i_sw[2:1]  = `NB_SEL'h1 ;
      #1000000 i_sw[2:1]  = `NB_SEL'h2 ;
      #1000000 i_sw[3]    = 1'b1       ;
      #1000000 i_sw[2:1]  = `NB_SEL'h3 ;
      #1000000 $stop;
  end

//generación  de clock
always #5 clock = ~clock;
top_shift_led
	#(
        .NB_LEDS    (NB_LEDS),
		.NB_SW      (NB_SW),
		.NB_COUNT   (NB_COUNT)
	)
    u_shift_leds
	(
		.o_led      (o_led),
		.o_led_b    (o_led_b),
		.o_led_g    (o_led_g),
		.i_sw       (i_sw),
        .i_reset    (i_reset),
        .clock      (clock)
);

endmodule 
