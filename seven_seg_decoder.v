module seven_seg_decoder(A, B, AplusB, AminusB, anode, segs);
    input [3:0] A;
    input [3:0] B;
    input [3:0] AplusB;
    input [3:0] AminusB;
    input [3:0] anode;
    output [6:0] segs;

    wire sel_A, sel_B, sel_AplusB, sel_AminusB;

    wire g, f, e, d, c, b, a;
    wire x, y, z, w;

    assign sel_A = ~anode[0]; 
    assign sel_B = ~anode[1]; 
    assign sel_AplusB = ~anode[2]; 
    assign sel_AminusB = ~anode[3];

    assign w = (sel_A & A[0]) | (sel_B & B[0]) | (sel_AplusB & AplusB[0]) | (sel_AminusB & AminusB[0]);
    assign z = (sel_A & A[1]) | (sel_B & B[1]) | (sel_AplusB & AplusB[1]) | (sel_AminusB & AminusB[1]);
    assign y = (sel_A & A[2]) | (sel_B & B[2]) | (sel_AplusB & AplusB[2]) | (sel_AminusB & AminusB[2]);
    assign x = (sel_A & A[3]) | (sel_B & B[3]) | (sel_AplusB & AplusB[3]) | (sel_AminusB & AminusB[3]);


    assign a = ~x & ~y & ~z &  w |
               ~x &  y & ~z & ~w |
                x & ~y &  z &  w |
                x &  y & ~z &  w;

    assign b = ~x &  y & ~z &  w |
                y &  z & ~w |
                x &  z & ~w |
                x &  y & ~w;

    assign c = ~x & ~y &  z & ~w |
                x &  y & ~w |
                x &  y &  z;

    assign d = ~x & ~y & ~z &  w |
               ~x &  y & ~z & ~w |
                y &  z &  w |
                x & ~y &  z & ~w;

    assign e = ~x &  w |
               ~x &  y & ~z |
               ~y & ~z &  w;

    assign f = ~x & ~y &  w |
               ~x & ~y &  z |
               ~x &  z &  w |
                x &  y & ~z &  w;

    assign g = ~x & ~y & ~z |
               ~x &  y &  z &  w |
                x &  y & ~z & ~w;

    assign segs = {g, f, e, d, c, b, a};

endmodule
