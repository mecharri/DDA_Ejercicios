// Toplevel del ejercicio 2 GP01
//! @title Top level del ejercicio 2
//! @file ej_2.v
//! @author MartinE

// Definiciones

module top_ej_2
#(
    parameter NB_DATA = 16
)
(
    output  [NB_DATA-1 : 0]     o_dataC,
    input   [NB_DATA-1 : 0]     i_dataA,
    input   [NB_DATA-1 : 0]     i_dataB,
    input   [1 : 0]             i_sel,
    input                       clock
);  //! Top level del ejercicio 2

//Definición de cables y reg

reg     [NB_DATA-1 : 0]    reg_operacion;
reg     [NB_DATA-1 : 0]    reg_o_dataC;

always @(*) begin
    case (i_sel)
        2'b00:  reg_operacion = i_dataA + i_dataB;
        2'b01:  reg_operacion = i_dataA - i_dataB;
        2'b10:  reg_operacion = i_dataA & i_dataB;
        2'b11:  reg_operacion = i_dataA | i_dataB;
    endcase
end

always @(posedge clock) begin
      reg_o_dataC = reg_operacion;
end

assign o_dataC = reg_o_dataC;

endmodule