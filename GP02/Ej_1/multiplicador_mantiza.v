//! @title Multiplicador de mantiza 1 GP02
//! @file multiplicador_mantiza.v
//! @author MartinE
// Se debe hacer con un multiplicador de 8x8 y para ello se deben tener en cuenta los casos donde importa el 1 que no se pone en la mantiza


module multiplicador_mantiza (
output  [7:0]   o_mantiza,
output          o_aviso_exponente,
input   [7:0]   i_mantiza_1,
input   [7:0]   i_mantiza_2
);

reg [15:0]  multiplicacion;
reg [8:0]   salida_multiplicador;
reg [7:0]   r_o_mantiza;
reg         r_o_aviso_exponente;

always @(*) begin
    multiplicacion = i_mantiza_1*i_mantiza_2;
    salida_multiplicador = {1'b0, multiplicacion[14:8]} + i_mantiza_1 + i_mantiza_2;
    r_o_aviso_exponente = salida_multiplicador[8];
    case (salida_multiplicador[8])
        1'b0: r_o_mantiza = salida_multiplicador[7:0];
        1'b1: r_o_mantiza = {1'b0, salida_multiplicador[7:1]};
    endcase
end

assign o_aviso_exponente = r_o_aviso_exponente;
assign o_mantiza = r_o_mantiza;

endmodule