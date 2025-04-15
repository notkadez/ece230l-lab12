module top #(parameter DIVIDE_BY = 17) (sw, clk, btnC, an, seg);
    input [7:0] sw; // A and B
    input clk; // 100 MHz board clock
    input btnC; // Reset
    output [3:0] an; // 7seg anodes
    output [6:0] seg; // 7seg segments

    wire [3:0] A, B;
    assign A = sw[3:0];
    assign B = sw[7:4];

    wire reset;
    wire div_clock;

    wire [3:0] AplusB;
    wire [3:0] AminusB;

    reg [6:0] segs_reg;
    assign seg = segs_reg;

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
        .segs(segs_reg)
    );

    // Instantiate the 7-segment scanner
    seven_seg_scanner seg_scanner (
        .div_clock(div_clock),
        .reset(reset),
        .anode(an)
    );

endmodule
