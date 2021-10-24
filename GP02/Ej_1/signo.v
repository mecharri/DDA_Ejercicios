//! @title Generación de signo para el ejercicio 1 GP02
//! @file signo.v
//! @author MartinE
// Se hace como un bloque aparte para que el toplevel sea solo conecciones sin lógica


module signo (
output      o_signo,
input       i_signo_1,
input       i_signo_2
);

reg r_o_signo;

always @(*) begin
    r_o_signo = i_signo_1^i_signo_2;
end

assign  o_signo = r_o_signo;

endmodule