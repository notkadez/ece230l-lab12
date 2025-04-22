module tff (
    input clk,
    input reset,
    input T,
    input Default,
    output reg Q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= Default;
        else if (T)
            Q <= ~Q;
    end
endmodule
