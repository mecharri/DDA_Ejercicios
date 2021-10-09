//! @title Bloque realimentación sincronico
//! @file realimentador.v
//! @author MartinE

module realimentador (
output  [5:0]   o_data,
output          o_overflow,
input   [3:0]   i_entrada,
input           i_rst_n,
input           clock
);

reg     [6:0]   sum;

//! Este always por un lado toma el reset asincrónico
//! y por otro lado si no hay reset => el clock está activo
//! y por lo tanto hace la suma del bloque realimentación
always @(posedge clock or negedge i_rst_n) begin
    if(!i_rst_n) begin
      //Está aplicado el reset => hay que resetear
      sum = 7'b0000000;
    end
    else begin
        //Si no está en cero el reset entonces hay que trabajar
        sum = {3'b000, i_entrada }+ sum;
    end
end

//! Se asignan los puntos a sacar por las salidas 
//! según corresponde
assign o_overflow = sum[6];
assign o_data = sum[5:0];

endmodule