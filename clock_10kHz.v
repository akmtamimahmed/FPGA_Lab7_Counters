module clock_10kHz(
    input clk_100MHz,
    output reg clk_10kHz = 0
    );

    reg [13:0] counter = 0; // Need to count to 5000

    always @(posedge clk_100MHz) begin
        if (counter >= 4999) begin // Toggle every 5000 ticks
            counter <= 0;
            clk_10kHz <= ~clk_10kHz; // Toggle output
        end else begin
            counter <= counter + 1;
        end
    end
endmodule