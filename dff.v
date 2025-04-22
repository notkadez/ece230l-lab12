module dff(
    input clk, 
    input rst,
    input D,
    input Default,
    output reg Q
);
    initial begin
        Q = Default;
    end

    always @(posedge clk, posedge rst) begin
        if (rst)
            Q <= Default;
        else
            Q <= D;
    end

endmodule
