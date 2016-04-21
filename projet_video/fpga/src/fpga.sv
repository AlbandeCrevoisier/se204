module fpga #(parameter HDISP = 640, VDISP = 480)
             (input fpga_CLK,           /* 50MHz clock */
             (input fpga_CLK_AUX,       /* 27MHz auxiliary clock */
             (input fpga_SW0,           /* command 0/1 */
             (input fpga_SW1,           /* command 0/1 */ 
             (input fpga_NRST,          /* command 0/1 */
             (output fpga_LEDR0,        /* LED 0 */
             (output fpga_LEDR1,        /* LED 1 */
             (output fpga_LEDR2,        /* LED 2 */
             (output fpga_LEDR3,        /* LED 3 */
             (output fpga_SEL_CLK_AUX); /* Setting this signal to 1 enables the
                                         * auxiliary clock.
                                         */

    `ifdef SIMULATION
        localparam clk_counter_27_max = 27;
        localparam clk_counter_50_max = 50;
    `else
        localparam clk_counter_27_max = 27_000_000;
        localparam clk_counter_50_max = 50_000_000;


    assign fpga_LEDR0 = fpga_SW0;
    assign fpga_SEL_CLK_AUX = fpga_SW1;
    assign fpga_LEDR3 = fpga_NRST;

    /* Make LED 1 blink at ~1Hz using the auxiliary clock. */
    logic clk_counter_27; /* binary counter */
    always_ff @(posedge fpga_CLK_AUX or negedge fpga_NRST)
        if (!fpga_NRST) begin
            fpga_LEDR1 <= 0;
            clk_counter_27 <= 0;
        end else begin
            clk_counter_27 <= clk_counter_27 + 1;
            if (clk_counter_27 == 27_000_000) begin
                fpga_LEDR1 <= !fpga_LEDR1;
                clk_counter_27 <= 0;
            end
        end
    
    /* Make LED 2 blink at ~1Hz using the clock. */
    logic clk_counter_50; /* binary counter */
    always_ff @(posedge fpga_CLK_AUX or negedge fpga_NRST)
        if (!fpga_NRST) begin
            fpga_LEDR2 <= 0;
            clk_counter_50 <= 0;
        end else begin
            clk_counter_50 <= clk_counter_50 + 2;
            if (clk_counter_50 == 50_000_000) begin
                fpga_LEDR2 <= !fpga_LEDR2;
                clk_counter_50 <= 0;
            end
        end
endmodule

