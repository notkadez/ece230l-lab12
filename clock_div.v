module clock_div #(
    parameter DIVIDE_BY = 17
)(
    input clock,
    input reset,
    output div_clock
);

    wire [DIVIDE_BY:0] clk_chain;
    wire [DIVIDE_BY-1:0] q_internal;

    assign clk_chain[0] = clock;

    genvar i;
    generate
        for (i = 0; i < DIVIDE_BY; i = i + 1) begin : tff_chain
            tff tff_inst (
                .clk(clk_chain[i]),
                .reset(reset),
                .T(1'b1),
                .Q(q_internal[i])
            );
            assign clk_chain[i+1] = q_internal[i];
        end
    endgenerate

    assign div_clock = clk_chain[DIVIDE_BY];

endmodule
