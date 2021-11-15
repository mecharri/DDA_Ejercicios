//! @title Bloque que suma los exponentes del ejercicio 1 GP02
//! @file sumador_exponente.v
//! @author MartinE
// Se hace como un bloque aparte para que el toplevel sea solo conecciones sin lógica


module sumador_exponente (
output  [3:0]  o_exponente,
input   [3:0]  i_exponente_1,
input   [3:0]  i_exponente_2,
input          i_carry_exponente
);

reg     [4:0]  r_primer_suma;
reg     [4:0]  r_o_exponente;

always @(*) begin
    r_primer_suma = {1'b0, i_exponente_1} + {1'b0, i_exponente_2}+ i_carry_exponente;
    r_o_exponente = r_primer_suma - 5'd7;
end

assign  o_exponente = r_o_exponente[3:0];

endmodule