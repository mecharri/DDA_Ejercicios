// Testbench del ejercicio 1 GP02
//! @title Testbech del GP02E1
//! @file tb_ej1.v
//! @author MartinE

`timescale  1ns/100ps

module tb_ej1();

wire  [12 : 0]      o_flotante;         //! Salida de multiplicación de flotantes
reg   [12 : 0]      i_flotante_1;       //! Flotante de entrada 1
reg   [12 : 0]      i_flotante_2;       //! Flotante de entrada 2

//Wires para cables internos para poder debugear

initial begin : estimulos

  //! Inicializo todas las entradas en cero
  i_flotante_1 = 13'd0;
  i_flotante_2 = 13'd0;
  //Float1 = 13b1_0101_11000110;//-0,443359375
  //Float2 = 13b0_1100_00011101;//35,625
  //Float3 = 13b0_0011_11001101;//0,112542828
  //Float4 = 13b1_1011_00101011;//-18,6875


//! Empiezo la parte temporal
    #50     i_flotante_1 = 13b1_0101_11000110;//-0,443359375
            i_flotante_2 = 13b0_1100_00011101;//35,625;
            //o_flotante = Float1 * Float2 = -0,443359375 * 35,625 = -15,79468

    #50     i_flotante_1 =  13b0_0011_11001101;//0,112542828
            i_flotante_2 =  13b1_1011_00101011;//-18,6875
            //o_flotante = Float3 * Float4 = 0,112542828 * -18,6875 = -2,103144

    #50     i_flotante_1 =  13b0_1100_00011101;//35,625
            i_flotante_2 =  13b0_0011_11001101;//0,112542828
            //o_flotante = Float2 * Float3 = 36.625 * 0,112542828 = 4,121881

    #50     i_flotante_1 = 13b1_0101_11000110;//-0,443359375
            i_flotante_2 =  13b1_1011_00101011;//-18,6875
            //o_flotante = Float1 * Float4 = -0,443359375 * -18,6875 = 8,285278

    //! Acá quiero probar que es conmutativa, copio los test de arriba y cambio la entrada 1 por la 2

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