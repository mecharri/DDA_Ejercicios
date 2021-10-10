//! @title Testbech del Ej1
//! @file tb_ej1.v
//! @author MartinE

// Definiciones

`timescale 1ns/100ps

module tb_ej1();

wire  [5:0]   o_data;       //! Salida de datos
wire          o_overflow;   //! Salida de overflow
reg   [2:0]   i_data1;      //! Dato de entrada 1
reg   [2:0]   i_data2;      //! Dato de entrada 2
reg           i_rst_n;      //! Reset asincrónico
reg   [1:0]   i_sel;        //! Selector
reg           clock;        //! Clock

wire  [3:0]  tb_suma_sumador; //! Punta de prueba para sumador selectivo

//! Leo la salida del módulo sumador selectivo y pongo la punta de prueba al wire que conecta los dos módulos
//assign tb_suma_sumador = tb_ej1.u_top_ej_1.w_sumador_realimentador;
//En el sintetizado lo comento porque no lo encuentra, está bien eso?
initial begin : estimulos
  //! Inicializo todas las entradas en cero
  clock       = 1'b0;
  i_data1   = 3'b000;
  i_data2   = 3'b000;
  i_sel     = 2'b00;
  i_rst_n   = 1'b0;

  //! Empiza la parte temporal
  //! Con clock moviendose pero reset en cero para que no se mueva la parte de realimentación
  //! Solo estoy probando el sumador
  #50       i_data1   =   3'd2;
            i_data2   =   3'd1;
  //! A la salida del sumador hay un decimal 1.
  //! Cambio i_sel para que a las salida del sumador esté la suma (3)
  #50       i_sel     =   2'b01;     
  //! Cambio i_sel para que a la salida del sumador esté i_data1 (2)
  #50       i_sel     =   2'b10;     
  //! Cambio i_sel para que a la salida sea cero  (0)
  #50       i_sel     =   2'b11;     

  //! Cambio i_sel_ para que a la salida haya un 1 decimal
  #50       i_sel     =   2'b01;

  //! Levanto el Reset para que arranque el realimentador
  #50       i_rst_n   =   1'b1;

  //! Dejo 10 ciclos de clock para que el realimentador funcione
  //! Ahora por el medio de un ciclo de reloj hago retest y tienen que hacerse cero las salidas
  #57        i_rst_n   =   1'b0;

  //! Ahora hago el punto del ejercicio
  #48       i_sel     =   2'd1;
            i_data1   =   3'd1;
            i_data2   =   3'd1;
            i_rst_n   =   1'b1;
  //! Ahora todos son 1
  //! También subí el reset para que funcione la parte sincronica
  //! Le doy 32 ciclos de reloj para que de overflow
  //! 32*10ns = 320ns + 10ns más para que se vea bien el overflow

  #330     i_rst_n   =   1'b0;
  //! bajo el reset en los 128 ciclos de clock más 2ns para comprobar que overflow subió
  #10     $stop;
end 

//! Generación del clock
always #5 clock = (~ clock);  //!Semiperiodo de 5ns => Perido de 10ns => F = 100MHz

//! Instancio el toplevel del ejercicio 1
top_ej_1
  u_top_ej_1
  (
    .o_data       (o_data),
    .o_overflow   (o_overflow),
    .i_data1      (i_data1),
    .i_data2      (i_data2),
    .i_rst_n      (i_rst_n),
    .i_sel        (i_sel),
    .clock        (clock)
  );

endmodule //tb_ej_1