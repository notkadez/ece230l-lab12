module math_block(
    input [3:0] A,
    input [3:0] B,
    output [3:0] AplusB,
    output [3:0] AminusB
);

    // Invert B for subtraction
    wire [3:0] B_not;
    assign B_not = ~B;

    wire [3:0] addC;
    wire [3:0] subC;

    // Addition: A + B
    full_adder add0(.a(A[0]), .b(B[0]),     .cin(1'b0),      .sum(AplusB[0]), .cout(addC[0]));
    full_adder add1(.a(A[1]), .b(B[1]),     .cin(addC[0]),   .sum(AplusB[1]), .cout(addC[1]));
    full_adder add2(.a(A[2]), .b(B[2]),     .cin(addC[1]),   .sum(AplusB[2]), .cout(addC[2]));
    full_adder add3(.a(A[3]), .b(B[3]),     .cin(addC[2]),   .sum(AplusB[3]), .cout(addC[3]));

    // Subtraction: A + (~B + 1)
    full_adder sub0(.a(A[0]), .b(B_not[0]), .cin(1'b1),      .sum(AminusB[0]), .cout(subC[0]));
    full_adder sub1(.a(A[1]), .b(B_not[1]), .cin(subC[0]),   .sum(AminusB[1]), .cout(subC[1]));
    full_adder sub2(.a(A[2]), .b(B_not[2]), .cin(subC[1]),   .sum(AminusB[2]), .cout(subC[2]));
    full_adder sub3(.a(A[3]), .b(B_not[3]), .cin(subC[2]),   .sum(AminusB[3]), .cout(subC[3]));

endmodule
