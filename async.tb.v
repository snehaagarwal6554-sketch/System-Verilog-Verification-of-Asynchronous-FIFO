module tb_async_fifo;
    parameter DATA_WIDTH = 8;
    logic wr_clk;
    logic rd_clk;
    logic rst_n;
    logic wr_en;
    logic rd_en;
    logic [DATA_WIDTH-1:0] data_in;
    logic [DATA_WIDTH-1:0] data_out;
    logic full;
    logic empty;
    logic [DATA_WIDTH-1:0] expected_queue[$];
    async_fifo dut (
        .wr_clk   (wr_clk),
        .rd_clk   (rd_clk),
        .rst_n    (rst_n),
        .wr_en    (wr_en),
        .rd_en    (rd_en),
        .data_in  (data_in),
        .data_out (data_out),
        .full     (full),
        .empty    (empty)
    );
    initial begin
        wr_clk = 0;
        forever #5 wr_clk = ~wr_clk;
    end
    initial begin
        rd_clk = 0;
        forever #7 rd_clk = ~rd_clk;
    end
    task reset_fifo();
        begin
            rst_n   = 0;
            wr_en   = 0;
            rd_en   = 0;
            data_in = 0;
            #30;
            rst_n = 1;
        end
    endtask
    task write_fifo(input logic [DATA_WIDTH-1:0] data);
        begin
            @(posedge wr_clk);
            if (!full) begin
                wr_en   <= 1;
                data_in <= data;
                expected_queue.push_back(data);
            end
            @(posedge wr_clk);
            wr_en <= 0;
        end
    endtask
    task read_fifo();
    logic [DATA_WIDTH-1:0] expected_data;
    begin
        @(posedge rd_clk);
        if (!empty) begin
            rd_en <= 1;
            @(posedge rd_clk);
            rd_en <= 0;
            #1;
            expected_data = expected_queue.pop_front();

            if (data_out === expected_data)
                $display("[%0t] READ PASS: Expected=%0d Received=%0d",
                         $time, expected_data, data_out);
            else
                $error("[%0t] READ FAIL: Expected=%0d Received=%0d",
                      $time, expected_data, data_out);
        end
    end
endtask
    initial begin
        wr_en   = 0;
        rd_en   = 0;
        data_in = 0;
        rst_n   = 0;
        reset_fifo();
        write_fifo(10);
        write_fifo(20);
        write_fifo(30);
        write_fifo(40);
        #50;
        read_fifo();
        read_fifo();
        read_fifo();
        read_fifo();
        #50;
        if (empty)
            $display("FIFO EMPTY TEST : PASS");
        else
            $error("FIFO EMPTY TEST : FAIL");
        #20;
        $finish;
    end
endmodule
