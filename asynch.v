module async_fifo (wr_clk,rd_clk,rd_clk,rst_n,wr_en,rd_en,data_in,data_out,full,empty);
    parameter DATA_WIDTH = 8;
    parameter DEPTH = 8;
    input  logic wr_clk;
    input  logic rd_clk;
    input  logic rst_n;
    input  logic wr_en;
    input  logic rd_en;
  input  logic [DATA_WIDTH-1:0] data_in;
  output logic [DATA_WIDTH-1:0] data_out;
    output logic full;
    output logic empty;
    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    integer wr_ptr;
    integer rd_ptr;
    integer count;
    initial begin
        wr_ptr = 0;
        rd_ptr = 0;
        count = 0;
        data_out = 0;
    end
    assign empty = (count == 0);
    assign full  = (count == DEPTH);
    always_ff @(posedge wr_clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= 0;
        end
        else if (wr_en && !full) begin
            mem[wr_ptr] <= data_in;
            wr_ptr <= (wr_ptr + 1) % DEPTH;
        end
    end
    always_ff @(posedge rd_clk or negedge rst_n) begin
        if (!rst_n) begin
            rd_ptr <= 0;
            data_out <= 0;
        end
        else if (rd_en && !empty) begin
            data_out <= mem[rd_ptr];
            rd_ptr <= (rd_ptr + 1) % DEPTH;
        end
    end
    always @(posedge wr_clk or posedge rd_clk or negedge rst_n) begin
        if (!rst_n)
            count <= 0;
        else begin
            if (wr_en && !full)
                count <= count + 1;
            else if (rd_en && !empty)
                count <= count - 1;
        end
    end
endmodule
