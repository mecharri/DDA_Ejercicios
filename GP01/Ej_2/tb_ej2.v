// Testbench del ejercicio 2 GP01
//! @title Testbech del Ej2
//! @file tb_ej2.v
//! @author MartinE

`timescale  1ns/100ps

module tb_ej2();

localparam  NB_DATA = 16;

wire    [NB_DATA-1 : 0]     o_dataC;    //! Salida de datos
reg     [NB_DATA-1 : 0]     i_dataA;    //! Dato de entrada 1
reg     [NB_DATA-1 : 0]     i_dataB;    //! Dato de entrada 2
reg     [1 : 0]             i_sel;      //! Selector de operación
reg                         clock;      //! Clock

initial begin : estimulos
  //! Inicializo todas las entradas en cero
  clock     = 1'b0;
  i_dataA   = 3'b000;
  i_dataB   = 3'b000;
  i_sel     = 2'b00;
  
//! Empiezo la parte temporal
    #50     i_dataA =   16'd-15;
            i_dataB =   16'd-15;
            i_sel   =   2'b00;
            //Salida es -15+-15 = -30

//! Cambio el selector
    #50     i_dataA =   16'd-15;
            i_dataB =   16'd-15;
            i_sel   =   2'b01;
            //Salida es -15--15 = 0

//! Cambio el selector
    #50     i_dataA =   16'd-15;
            i_dataB =   16'd-15;
            i_sel   =   2'b10;
            //Salida es -15 & -15 = -30

//! Cambio el selector
    #50     i_dataA =   16'd-15;
            i_dataB =   16'd-15;
            i_sel   =   2'b11;
            //Salida es -15 | -15 = -30



end
//! Generación del clock
always #5 clock = (~ clock);  //!Semiperiodo de 5ns => Perido de 10ns => F = 100MHz

//! Instancio el top del Ej2

top_ej_2
    #(
        .NB_DATA    (NB_DATA)
    )
    u_top_ej_2
    (
        .o_dataC    (o_dataC),
        .i_dataA    (i_dataA),
        .i_dataB    (i_dataB),
        .i_sel      (i_sel),
        .clock      (clock)
    );  //! Top level del ejercicio 2

endmodule