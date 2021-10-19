// Testbech del ejercicio 4 GP01
//! @title Testbech del Ej4
//! @file tb_ej4.v
//! @author MartinE

`timescale  1ns/100ps

module tb_ej4();

localparam  NB_DATA = 8;

wire  [NB_DATA-1 : 0]      o_y;         //! Salida de datos
reg   [NB_DATA-1 : 0]      i_x;         //! Entrada de datos
reg                        i_rst_n;     //! Entrada de reset
reg                        clock;       //! Clock


//Wires para cables internos para poder debugear

wire [NB_DATA-1 : 0]       w_ym1;
wire [NB_DATA-1 : 0]       w_ym2;
wire [NB_DATA-1 : 0]       w_ym1_s;
wire [NB_DATA-1 : 0]       w_ym2_s;

wire [NB_DATA-1 : 0]       w_xm1;
wire [NB_DATA-1 : 0]       w_xm2;
wire [NB_DATA-1 : 0]       w_xm3;
wire [NB_DATA-1 : 0]       w_xm4;


assign  w_ym1 = tb_ej4.u_top_ej_4.r_ym1;
assign  w_ym2 = tb_ej4.u_top_ej_4.r_ym2;
assign  w_ym1_s = tb_ej4.u_top_ej_4.r_ym1 >>> 1;
assign  w_ym2_s = tb_ej4.u_top_ej_4.r_ym2 >>> 2;

assign  w_xm1 = tb_ej4.u_top_ej_4.r_xm1;
assign  w_xm2 = tb_ej4.u_top_ej_4.r_xm2;
assign  w_xm3 = tb_ej4.u_top_ej_4.r_xm3;

initial begin : estimulos
$dumpfile("tb_ej4.vcd");
$dumpvars(clock,i_x,i_rst_n,o_y,w_ym1,w_ym1_s,w_ym2,w_ym2_s,w_xm1,w_xm2,w_xm3);
  //! Inicializo todas las entradas en cero
  clock     = 1'b0;
  i_x       = 8'b0000_0000;
  i_rst_n   = 1'b0;
  
//! Empiezo la parte temporal
    #50     i_x     =   8'd1;
            i_rst_n =   1'b1;
            // x[n]   = 1
            // x[n-1] = 0
            // x[n-2] = 0
            // x[n-3] = 0
            // y[n-1] = 0
            // y[n-2] = 0
            // y[n]   =   x[n] - x[n-1] + x[n-2] + x[n-3] + 0,5*y[n-1] + 0,25*y[n-2] =  1-0+0+0+0,5*0+0,25*0 = 1 
    
    //Dejo pasar 1 clock 
    #10     i_x     =   8'd2;
            // x[n]   = 2
            // x[n-1] = 1
            // x[n-2] = 0
            // x[n-3] = 0
            // y[n-1] = 1
            // y[n-2] = 0
            // y[n]   =   x[n] - x[n-1] + x[n-2] + x[n-3] + 0,5*y[n-1] + 0,25*y[n-2] =  2-1+0+0+0,5*1+0,25*0 = 1,5 (recorta a 1)
            
    //Dejo pasar 1 clock 
    #10     i_x     =   8'd3;
            // x[n]   = 3
            // x[n-1] = 2
            // x[n-2] = 1
            // x[n-3] = 0
            // y[n-1] = 1
            // y[n-2] = 1
            // y[n]   =   x[n] - x[n-1] + x[n-2] + x[n-3] + 0,5*y[n-1] + 0,25*y[n-2] =  3-2+1+0+0,5*1+0,25*1 = 2,75 (recorta a 2)

            
    //Dejo pasar 1 clock 
    #10     i_x     =   8'd4;
            // x[n]   = 4
            // x[n-1] = 3
            // x[n-2] = 2
            // x[n-3] = 1
            // y[n-1] = 2
            // y[n-2] = 1
            // y[n]   =   x[n] - x[n-1] + x[n-2] + x[n-3] + 0,5*y[n-1] + 0,25*y[n-2] =  4-3+2+1+0,5*2+0,25*1 = 5,25 (recorta a 5)
            
    //Dejo pasar 1 clock 
    #10     i_x     =   8'd1;
            // x[n]   = 1
            // x[n-1] = 4
            // x[n-2] = 3
            // x[n-3] = 2
            // y[n-1] = 5
            // y[n-2] = 2
            // y[n]   =   x[n] - x[n-1] + x[n-2] + x[n-3] + 0,5*y[n-1] + 0,25*y[n-2] =  1-4+3+2+0,5*5+0,25*2 = 5 (recorta a 4)

            
    //Dejo pasar 1 clock 
    #10     i_x     =   8'd2;
            // x[n]   = 2
            // x[n-1] = 1
            // x[n-2] = 4
            // x[n-3] = 3
            // y[n-1] = 4
            // y[n-2] = 5
            // y[n]   =   x[n] - x[n-1] + x[n-2] + x[n-3] + 0,5*y[n-1] + 0,25*y[n-2] =  2-1+4+3+0,5*4+0,25*5 = 11,25  (recorta a 11)


    #10     $finish;

end
//! Generación del clocks
always #5 clock = (~ clock);  //!Semiperiodo de 5ns => Perido de 10ns => F = 100MHz

//! Instancio el top del Ej2

top_ej_4
    #(
        .NB_DATA    (NB_DATA)
    )
    u_top_ej_4
    (
        .o_y        (o_y),
        .i_x        (i_x),
        .i_rst_n    (i_rst_n),
        .clock      (clock)
    );  //! Instancio el top del ejercicio 4

endmodule