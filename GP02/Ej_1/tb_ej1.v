// Testbench del ejercicio 1 GP02
//! @title Testbech del GP02E1
//! @file tb_ej1.v
//! @author MartinE

`timescale  1ns/100ps

module tb_ej1();

wire  [12 : 0]      o_flotante;         //! Salida de multiplicación de flotantes
reg   [12 : 0]      i_flotante_1;       //! Flotante de entrada 1
reg   [12 : 0]      i_flotante_2;       //! Flotante de entrada 2
reg                 clock;           

wire  [12 : 0]      w_coneccion_salida_mutiplicado ; //! 

//Wires para cables internos para poder debugear

initial begin : estimulos
  clock = 0;
  //! Inicializo todas las entradas en cero
  i_flotante_1 = 13'd0;
  i_flotante_2 = 13'd0;
  //Float1 = 13'b1_0101_11000110;//-0,443359375
  //Float2 = 13'b0_1100_00011101;//35,625
  //Float3 = 13'b0_0011_11001101;//0,112542828
  //Float4 = 13'b1_1011_00101011;//-18,6875


//! Empiezo la parte temporal
    #50     i_flotante_1 = 13'b1_0101_11000110;  //-0,443359375
            i_flotante_2 = 13'b0_1100_00011101;  //35,625;
            //o_flotante = Float1 * Float2 = -0,443359375 * 35,625 = -15,79468
            //Dio 1101011101110 que es -15,4375

    #50     i_flotante_1 =  13'b0_0011_11001101;//0,112542828
            i_flotante_2 =  13'b1_1011_00101011;//-18,6875
            //o_flotante = Float3 * Float4 = 0,112542828 * -18,6875 = -2,103144
            //Dio 1011100000100 que es -1,015625

    #50     i_flotante_1 =  13'b0_1100_00011101;//35,625
            i_flotante_2 =  13'b0_0011_11001101;//0,112542828
            //o_flotante = Float2 * Float3 = 36.625 * 0,112542828 = 4,121881
            //Dio 0100011110101 que es 3,91406

    #50     i_flotante_1 =  13'b1_0101_11000110;//-0,443359375
            i_flotante_2 =  13'b1_1011_00101011;//-18,6875
            //o_flotante = Float1 * Float4 = -0,443359375 * -18,6875 = 8,285278
            //Dio 0100100000000 que es 4

    //! Acá quiero probar que es conmutativa, copio los test de arriba y cambio la entrada 1 por la 2

    #10     $finish;

end
//! Generación del clocks
always #5 clock = (~ clock);  //!Semiperiodo de 5ns => Perido de 10ns => F = 100MHz

//! Instancio el top del Ej2

top_ej1
    u_top_ej1
    (
        .o_mutiplicado  (o_flotante),
        .i_flotante_1   (i_flotante_1),
        .i_flotante_2   (i_flotante_2)
    );//! Toplevel del Ej1

    //assign o_flotante = w_coneccion_salida_mutiplicado;

endmodule