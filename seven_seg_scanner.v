module seven_seg_scanner(
    input div_clock,
    input reset,
    output [3:0] anode
);

    wire Anext, Bnext, Cnext, Dnext;
    wire Astate, Bstate, Cstate, Dstate;
    
    dff Adff(
        .D(Anext),
        .Default(1'b0),
        .clk(div_clock),
        .rst(reset),
        .Q(Astate)
    );

    dff Bdff(
        .D(Bnext),
        .Default(1'b1),
        .clk(div_clock),
        .rst(reset),
        .Q(Bstate)
    );

    dff Cdff(
        .D(Cnext),
        .Default(1'b1),
        .clk(div_clock),
        .rst(reset),
        .Q(Cstate)
    );
    
    dff Ddff(
        .D(Dnext),
        .Default(1'b1),
        .clk(div_clock),
        .rst(reset),
        .Q(Dstate)
    );

    assign Anext = Dstate;
    assign Bnext = Astate;
    assign Cnext = Bstate;
    assign Dnext = Cstate;
    
    assign anode = {Dstate, Cstate, Bstate, Astate};

endmodule
