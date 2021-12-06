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


//Wires para cables internos para poder debugear
wire [15:0]       w_tb_multiplicacion;
wire [15:0]       w_tb_salida_multiplicador;
//! Leo la salida del módulo sumador selectivo y pongo la punta de prueba al wire que conecta los dos módulos
assign w_tb_multiplicacion = tb_ej1.u_top_ej1.u_multiplicador_mantiza.multiplicacion;
assign w_tb_salida_multiplicador = tb_ej1.u_top_ej1.u_multiplicador_mantiza.salida_multiplicador;

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
            //o_flotante = Float1 * Float2 = -0,443359375 * 35,625 = -15,79467773
            //Dio           1_1010_11101110 que es -15,4375
            //Tiene que dar 1_1010_11111001 que es -15,78125 => Hay un problema en la mantiza

    #50     i_flotante_1 =  13'b0_0011_11001101;//0,112542828
            i_flotante_2 =  13'b1_1011_00101011;//-18,6875
            //o_flotante = Float3 * Float4 = 0,112542828 * -18,6875 = -2,103256
            //Dio           1_1000_00000100 que es -2,03125
            //Tiene que dar 1_1000_00001101 que es -2,1015625

    #50     i_flotante_1 =  13'b0_1100_00011101;//35,625
            i_flotante_2 =  13'b0_0011_11001101;//0,112542828
            //o_flotante = Float2 * Float3 = 36.625 * 0,112542828 = 4,00955
            //Dio           0_1000_11110101 que es 3,9140625
            //Tiene que dar 0_1001_00000000 que es 4

    #50     i_flotante_1 =  13'b1_0101_11000110;//-0,443359375
            i_flotante_2 =  13'b1_1011_00101011;//-18,6875
            //o_flotante = Float1 * Float4 = -0,443359375 * -18,6875 = 8,28527832
            //Dio           0_1010_00000000 que es 8
            //Tiene que dar 0_1010_00001001 que es 8,28125
                
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


endmodule