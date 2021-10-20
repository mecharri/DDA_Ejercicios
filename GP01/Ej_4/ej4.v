// Toplevel del ejercicio 4 GP01
//! @title Toplevel del Ej4
//! @file ej4.v
//! @author MartinE

module top_ej_4
#(
    parameter NB_DATA  =   16
)
(
    output  [NB_DATA-1 : 0]      o_y,
    input   [NB_DATA-1 : 0]      i_x,
    input                        i_rst_n,
    input                        clock
);

reg     [NB_DATA-1 : 0]      r_xm1;             //! x[n-1]
reg     [NB_DATA-1 : 0]      r_xm2;             //! x[n-2]
reg     [NB_DATA-1 : 0]      r_xm3;             //! x[n-3]
reg     [NB_DATA-1 : 0]      r_y;               //! y[n]
reg     [NB_DATA-1 : 0]      r_ym1;             //! y[n-1]
reg     [NB_DATA-1 : 0]      r_ym1_shifted;     //! y[n-1]*0,5
reg     [NB_DATA-1 : 0]      r_ym2;             //! y[n-2]*0,25
reg     [NB_DATA-1 : 0]      r_ym2_shifted;     //! y[n-1]

always  @(posedge clock or negedge i_rst_n )
begin

    if(!i_rst_n) begin
        r_xm1   =  0;  //! Pongo todo en cero
        r_xm2   =  0;
        r_xm3   =  0;
        r_y     =  0;
        r_ym1   =  0;
        r_ym2   =  0;
    end
    else begin

        //! Hago los shift
        r_ym1_shifted = r_ym1 >>> 1;
        r_ym2_shifted = r_ym2 >>> 2;
        //! Hago la cuenta
        r_y     =  i_x + r_ym1_shifted + r_ym2_shifted- r_xm1 + r_xm2 + r_xm3 ;
        //! y   =   x[n] - x[n-1] + x[n-2] + x[n-3] + 0,5*y[n-1] + 0,25*y[n-2]

       //! Actualizo el historial de las entradas
        r_xm3   <=  r_xm2;
        r_xm2   <=  r_xm1;
        r_xm1   <=  i_x;
        
        //! Actualizo el historial de las salidas
        r_ym2   <=  r_ym1;
        r_ym1   <=  r_y;
    end

end 

assign o_y = r_y;
endmodule