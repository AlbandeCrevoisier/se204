module tb_fpga;

    /* input */
    logic fpga_CLK, fpga_CLK_AUX, fpga_SW0, fpga_SW1, fpga_NRST;
    /* output */
    logic fpga_LEDR0, fpga_LEDR1, fpga_LEDR2, fgpa_LEDR3, fpga_SEL_CLK_AUX;

    /* Generate 50MHz clock. */
    always #10ns
        fpga_CLK = ~fpga_CLK;

    /* Generate 27MHz clock. */
    always #18.519
        if (fpga_SEL_CLK_AUX)
            fpga_CLK_AUX = ~fpga_CLK_AUX;

    initial
    begin
        /* Test SW0, SW1, and NRST. */
        fpga_SW0 = 0;
        fpga_SW1 = 0;
        fpga_NRST = 0;
        repeat(42) begin
            @posedge(fpga_CLK);
            fpga_SW0 = ~fpga_SW0;
            fpga_SW1 = ~fpga_SW1;
            fpga_NRST = ~fpga_NRST;
        end
    end

    fpga fpga(
        .fpga_CLK(fpga_CLK),
        .fpga_CLK_AUX(fpga_CLK_AUX),
        .fpga_SW0(fpga_SW0),
        .fpga_SW1(fpga_SW1),
        .fpga_NRST(fpga_NRST),
        .fpga_LEDR0(fpga_LEDR0),
        .fpga_LEDR1(fpga_LEDR1),
        .fpga_LEDR2(fpga_LEDR2),
        .fpga_LEDR3(fpga_LEDR3),
        .fpga_SEL_CLK_AUX(fpga_SEL_CLK_AUX));
endmodule

