//! @title Top level del ejercicio 1
//! @file ej_1.v
//! @author MartinE

// Definiciones

`timescale 1ns/100ps
 
module top_ej_1(
    //Puertos comentados para usarlos vía el VIO
//    output  [5:0]   o_data,
//    output          o_overflow,
//    input   [2:0]   i_data1,
//   input   [2:0]   i_data2,
//    input           i_rst_n,
//    input   [1:0]   i_sel,
    input           clock
);//! Toplevel del Ej1


//Wire que conecta el sumador con el realimentador
wire    [3:0]   w_sumador_realimentador;    //! Wire que conecta el sumador con el realimentador
wire    [5:0]   w_o_data;                   //! Wire que conecta la salida del realimentador a la salida del toplevel
wire            w_o_overflow;               //! Wire que conecta la salida del sumador con la salida del toplevel

//Cables para conectar el VIO con el toplevel
//Comentar si se simula sin el VIO
wire    [5:0]   o_data;
wire            o_overflow;
wire    [2:0]   i_data1;
wire    [2:0]   i_data2;
wire            i_rst_n;
wire    [1:0]   i_sel;


//! Instacio un bloque realimentador
realimentador 
    u_realimentador
    (
        .o_data     (w_o_data),
        .o_overflow (w_o_overflow),
        .i_entrada  (w_sumador_realimentador),
        .i_rst_n    (i_rst_n),
        .clock        (clock)
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

//! Instancio el VIO
//Comentar si se simula sin el VIO
 vio
    u_vio
    (
        .clk_0          (clock),
        .probe_in0_0    (o_data),
        .probe_in1_0    (o_overflow),
        .probe_out0_0   (i_data1),
        .probe_out1_0   (i_data2),
        .probe_out2_0   (i_sel),
        .probe_out3_0   (i_rst_n)
    );

//! Asigno las salidas de los modulos a la salida del toplevel
assign o_data       =   w_o_data;
assign o_overflow   =   w_o_overflow;

endmodule