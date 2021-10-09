//! @title Top level del ejercicio 1
//! @file ej_1.v
//! @author MartinE

// Definiciones

`timescale 1ns/100ps
 
module top_ej_1(
    output  [5:0]   o_data,
    output          o_overflow,
    input   [2:0]   i_data1,
    input   [2:0]   i_data2,
    input           i_rst_n,
    input   [1:0]   i_sel,
    input           clk
);//! Toplevel del Ej1


//Wire que conecta el sumador con el realimentador
wire    [3:0]   w_sumador_realimentador;    //! Wire que conecta el sumador con el realimentador
wire    [5:0]   w_o_data;                   //! Wire que conecta la salida del realimentador a la salida del toplevel
wire            w_o_overflow;               //! Wire que conecta la salida del sumador con la salida del toplevel

//! Instacio un bloque realimentador
realimentador 
    u_realimentador
    (
        .o_data     (w_o_data),
        .o_overflow (w_o_overflow),
        .i_entrada  (w_sumador_realimentador),
        .i_rst_n    (i_rst_n),
        .clk      (clk)
    );



//! Instancio un bloque de suma con selección
sumador_selectivo 
    u_sumador_selectivo
    (
        .o_suma(w_sumador_realimentador),
        .i_data1(i_data1),
        .i_data2(i_data2),
        .i_sel(i_sel)
    );

//! Asigno las salidas de los modulos a la salida del toplevel
assign o_data       =   w_o_data;
assign o_overflow   =   w_o_overflow;

endmodule