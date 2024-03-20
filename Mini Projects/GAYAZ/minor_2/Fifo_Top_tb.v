`timescale 1ns/1ps
module Fifo_Top_tb();

    reg wr_clk, rd_clk, wr_rst, rd_rst, wr_en, rd_en;
    reg [7:0] wr_data;
    wire [7:0] rd_data;
    wire o_fifo_full, o_fifo_empty;

    // Instantiate the module under test
    Fifo_Top_Module #(12) dut (
        .wr_clk(wr_clk),
        .rd_clk(rd_clk),
        .wr_rst(wr_rst),
        .rd_rst(rd_rst),
        .wr_data(wr_data),
        .rd_data(rd_data),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .o_fifo_full(o_fifo_full),
        .o_fifo_empty(o_fifo_empty)
    );

    // Clock generation
    always begin
        wr_clk = 1'b0;
        #1; 
        wr_clk = 1'b1;
        #1; 
    end

    always begin
        rd_clk = 1'b0;
        #2; 
        rd_clk = 1'b1;
        #2; 
    end

    initial begin
        wr_rst = 1'b1;
        rd_rst = 1'b1;
        wr_en = 1'b0;
        rd_en = 1'b0;
        wr_data = 8'h00;

        #20;
        wr_rst = 1'b0;
        rd_rst = 1'b0;

        wr_en = 1'b1;
        wr_data = 8'h34;
        #20;
        wr_data = 8'hA8;
        #20;
        wr_data = 8'h0F;
        #20;
        wr_data = 8'hAB;
        #20;
        wr_data = 8'h09;
      
        #20;
        wr_en = 1'b0;

        rd_en = 1'b1;
        #40;
      	rd_en = 8'h10;
      	#20
        rd_en = 1'b0;
    end
   initial begin
   	 $monitor("o_fifo_full=%0d, o_fifo_empty=%0d, wr_data=%0d, rd_data=%0d, wr_en=%0d,rd_en=%0d,",o_fifo_full,o_fifo_empty,wr_data,rd_data,wr_en,rd_en);        		 
    end
    initial begin
        $dumpfile ("dump.vcd");
        $dumpvars ();
    end
    initial begin
        #100 $finish ();
    end

endmodule