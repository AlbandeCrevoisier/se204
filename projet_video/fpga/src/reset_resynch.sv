module reset_resynch #(parameter reset_state = 0)
                      (input clk,
                       input n_rst,
                       output rst);

    logic tmp;
    always_ff @(posedge clk or negedge n_rst)
        if (!n_rst) begin
            rst <= reset_state;
        end else begin
            tmp <= !reset_state;
            rest <= tmp;
        end

endmodule

