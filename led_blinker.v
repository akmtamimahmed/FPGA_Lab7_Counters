module led_blinker(
    input clk,       // 100MHz system clock
    output reg led   // LED output
    );

    // 29-bit counter to hold up to 300,000,000
    reg [28:0] counter = 0;

    always @(posedge clk) begin
        if (counter >= 299999999) begin
            counter <= 0; // Reset after 3 seconds
        end else begin
            counter <= counter + 1;
        end

        // Logic: ON for first 2 seconds (0 to 199,999,999)
        // OFF for last 1 second (200,000,000 to 299,999,999)
        if (counter < 200000000)
            led <= 1'b1;
        else
            led <= 1'b0;
    end
endmodule