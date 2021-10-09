//! @title Testbech del Ej1
//! @file tb_ej1.v
//! @author MartinE

// Definiciones

'timescale 1ns/100ps

module tb_ej1();

wire  [5:0]   o_data;       //! Salida de datos
wire          o_overflow;   //! Salida de overflow
reg   [2:0]   i_data1;      //! Dato de entrada 1
reg   [2:0]   i_data2;      //! Dato de entrada 2
reg           i_rst_n;      //! Reset asincrónico
reg   [1:0]   i_sel;        //! Selector
reg           clk;          //! Clock

wire  [3:0]  tb_suma_sumador; //! Punta de prueba para sumador selectivo

//! Leo la salida del módulo sumador selectivo y pongo la punta de prueba al wire que conecta los dos módulos
assign tb_suma_sumador = tb_ej1.w_sumador_realimentador;

initial begin : estimulos
  //! Inicializo todas las entradas en cero
  clk       = 1'b0;
  i_data1   = 3'b000;
  i_data2   = 3'b000;
  i_sel     = 2'b00;
  i_rst_n   = 1'b0;

  //! Empiza la parte temporal
  //! Con clock moviendose pero reset en cero para que no se mueva la parte de realimentación
  //! Solo estoy probando el sumador
  #50       i_data1   =   3'd2;
  #50       i_data2   =   3'd1;
  //! A la salida del sumador hay un decimal 1.
  //! Cambio i_sel para que a las salida del sumador esté la suma (3)
  #100      i_sel     =   2'b01;     
  //! Cambio i_sel para que a la salida del sumador esté i_data1 (2)
  #150      i_sel     =   2'b10;     
  //! Cambio i_sel para que a la salida sea cero  (0)
  #200      i_sel     =   2'b11;     

  //! Cambio i_sel_ para que a la salida haya un 1 decimal
  #250      i_sel     =   2'b01;

  //! Levanto el Reset para que arranque el realimentador
  #300      i_rst_n   =   1'b1;

  //! Dejo 10 ciclos de clock para que el realimentador funcione
  //! Ahora por el medio de un ciclo de reloj hago retest y tienen que hacerse cero las salidas
  #403      i_rst_n   =   1'b0;

  //! Ahora hago el punto del ejercicio
  #450      i_sel     =   2'd1;
  #450      i_data1   =   3'd1;
  #450      i_data2   =   3'd1;
  //! Ahora todos son 1
  //! Le doy 128 ciclos de reloj para que de overflow
  //! 128*10ns + 450ns = 1730ns

  #1732     i_rst_n   =   1'b0;
  //! bajo el reset en los 128 ciclos de clock más 2ns para comprobar que overflow subió

end 

//! Generación del clock
always #5 clk = (~ clk);  //!Semiperiodo de 5ns => Perido de 10ns => F = 100MHz

//! Instancio el toplevel del ejercicio 1
top_ej_1
  u_top_ej_1
  (
    .o_data       (o_data)
    .o_overflow   (o_overflow)
    .i_data1      (i_data1)
    .i_data2      (i_data2)
    .i_rst_n      (i_rst_n)
    .i_sel        (i_sel)
    .clk          (clk)
  )

endmodule