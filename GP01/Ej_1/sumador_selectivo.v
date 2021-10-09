//! @title Bloque de sumador selectivo
//! @file sumador_selectivo.v
//! @author MartinE

// Definiciones

`timescale 1ns/100ps

module sumador_selectivo (
    output  [3:0]  o_suma,  //! Salida de la suma
    input   [2:0]  i_data1, //! Entrada 1
    input   [2:0]  i_data2, //! Entrada 2
    input   [1:0]  i_sel    //! Selector de suma
);

reg    [3:0]   salida_mux;  //Defino un registro para que a la salida sea un registro?

//! Descripción del bloque
always @(*) begin : selector_de_suma
    case (i_sel)
        2'b00:  salida_mux = {1'b0,i_data2};
        2'b01:  salida_mux = (i_data1 + i_data2);
        2'b10:  salida_mux = {1'b0, i_data1};
        2'b11:  salida_mux = 4'b0000;   //Agrego el caso de que i_sel sea 3, 
    endcase
end

assign o_suma = salida_mux;

endmodule