module top(A, B, segs, anode, clock, reset);
    input [3:0] A;
    input [3:0] B;
    input clock;
    input reset;
    output [6:0] segs;
    output [3:0] anode;

    reg [3:0] segs_reg;

    wire [3:0] AplusB;
    wire [3:0] AminusB;

    wire div_clock;

    assign segs = segs_reg;

    // Instantiate the clock divider
    clock_div #(17) div_clk (
        .clock(clock),
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
        .anode(anode),
        .segs(segs_reg)
    );

    // Instantiate the 7-segment scanner
    seven_seg_scanner seg_scanner (
        .div_clock(div_clock),
        .reset(reset),
        .anode(anode)
    );

endmodule
