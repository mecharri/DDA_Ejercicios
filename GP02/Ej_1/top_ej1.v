//! @title Top level del ejercicio 1 GP02
//! @file to_ej1.v
//! @author MartinE

// Multiplicador de punto flotante de 13 bits
//  |   1b      |       4b      |   8b      |
//  |   Signo   |   exponente   |   mantiza |
//  Sesgo del exponente: 7

// Definiciones

module top_ej1(
    output  [12:0]   o_mutiplicado,
    input   [12:0]   i_flotante_1,
    input   [12:0]   i_flotante_2
);//! Toplevel del Ej1

//Wire que conecta el sumador con el realimentador
wire            w_signo_salida;        //! Wire del de salida
wire    [3:0]   w_exponente_salida;    //! Wire del de salida
wire    [7:0]   w_mantiza_salida;      //! Wire del de salida

//! Instancio un bloque de cálculo del signo
signo 
    u_signo
    (
        .o_signo    (w_signo_salida),
        .i_signo_1  (i_flotante_1[12]),
        .i_signo_2  (i_flotante_2[12])
);

//! Instancio un bloque de suma de exponente
sumador_exponente
    u_sumador_exponente
    (
        .o_exponente    (w_exponente_salida),
        .i_exponente_1  (i_flotante_1[11:8]),
        .i_exponente_2  (i_flotante_2[11:8])
);

//! Instancio un bloque de multiplicación de mantiza
multiplicador_mantiza
    u_multiplicador_mantiza
    (
        .o_mantiza      (w_mantiza_salida),
        .i_mantiza_1    (i_flotante_1[7:0]),
        .i_mantiza_2    (i_flotante_2[7:0])
    );


//! Asigno las salidas de los modulos a la salida del toplevel
assign  o_mutiplicado = {w_signo_salida , w_exponente_salida , w_mantiza_salida};


endmodule