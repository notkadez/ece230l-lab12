module math_block(A, B, AplusB, AminusB);
    input [3:0] A;
    input [3:0] B;
    output [3:0] AplusB;
    output [3:0] AminusB;


    wire [3:0] B_not;
    wire [3:0] sum_add;
    wire [3:0] sum_sub;
    wire c1, c2, c3, c4, c5, c6;

    // Invert B for subtraction
    assign B_not[0] = ~B[0];
    assign B_not[1] = ~B[1];
    assign B_not[2] = ~B[2];
    assign B_not[3] = ~B[3];

    // Addition: A + B
    full_adder add0(.a(A[0]), .b(B[0]),     .cin(1'b0), .sum(AplusB[0]), .cout(c1));
    full_adder add1(.a(A[1]), .b(B[1]),     .cin(c1),   .sum(AplusB[1]), .cout(c2));
    full_adder add2(.a(A[2]), .b(B[2]),     .cin(c2),   .sum(AplusB[2]), .cout(c3));
    full_adder add3(.a(A[3]), .b(B[3]),     .cin(c3),   .sum(AplusB[3]), .cout());

    // Subtraction: A + (~B + 1)
    full_adder sub0(.a(A[0]), .b(B_not[0]), .cin(1'b1), .sum(AminusB[0]), .cout(c4));
    full_adder sub1(.a(A[1]), .b(B_not[1]), .cin(c4),   .sum(AminusB[1]), .cout(c5));
    full_adder sub2(.a(A[2]), .b(B_not[2]), .cin(c5),   .sum(AminusB[2]), .cout(c6));
    full_adder sub3(.a(A[3]), .b(B_not[3]), .cin(c6),   .sum(AminusB[3]), .cout());

endmodule
