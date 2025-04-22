module top #(parameter DIVIDE_BY = 12) (
    input [7:0] sw,
    input clk,
    input btnC,
    output [3:0] an,
    output [6:0] seg
);
    wire [3:0] A, B;
    assign A = sw[3:0];
    assign B = sw[7:4];

    wire reset;
    assign reset = btnC;

    wire div_clock;

    wire [3:0] AplusB;
    wire [3:0] AminusB;

    // Instantiate the clock divider
    clock_div #(DIVIDE_BY) div_clk (
        .clock(clk),
        .reset(reset),
        .div_clock(div_clock)
    );

    // Instantiate the 4-bit adder/subtractor
    math_block adder_sub (
        .A(A),
        .B(B),
        .AplusB(AplusB),
        .AminusB(AminusB)
    );

    // Instantiate the 7-segment decoder
    seven_seg_decoder seg_decoder (
        .A(A),
        .B(B),
        .AplusB(AplusB),
        .AminusB(AminusB),
        .anode(an),
        .segs(seg)
    );

    // Instantiate the 7-segment scanner
    seven_seg_scanner seg_scanner (
        .div_clock(div_clock),
        .reset(reset),
        .anode(an)
    );

endmodule
