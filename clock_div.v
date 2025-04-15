module clock_div #(parameter DIVIDE_BY = 17) (clock, reset, div_clock);
    input clock;
    input reset;
    output div_clock;

    // 100 MHz input clock, divide down by chaining N FlipFlops together
    // to slow down the clock by 1/2^N

    wire [DIVIDE_BY:0] q;
    wire [DIVIDE_BY-1:0] notq;

    assign q[0] = clock;

    genvar i;
    generate
        for (i = 0; i < DIVIDE_BY; i = i + 1) begin
            dff inst (
                .reset(reset),
                .Default(1'b0),
                .clock(q[i]),
                .D(notq[i]),
                .Q(q[i+1]),
                .NotQ(notq[i])
            );
        end
    endgenerate

    assign div_clock = q[DIVIDE_BY];

endmodule
