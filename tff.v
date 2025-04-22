module tff (
    input clk,
    input reset,
    input T,
    output reg Q
);
    always @(posedge clk, posedge reset) begin
        if (reset)
            Q <= 'b0;
        else if (T)
            Q <= ~Q;
    end
endmodule
