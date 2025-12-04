module Lab7_Master_Top(
    input CLK100MHZ,        // System Clock
    input [15:0] SW,        // Switches
    output [15:0] LED,      // Standard LEDs
    output [6:0] SEG,       // 7-Segment Segments (Cathodes)
    output [7:0] AN,        // 7-Segment Anodes
    output LED16_R,         // RGB LED 1 Red
    output LED16_G,         // RGB LED 1 Green
    output LED16_B,         // RGB LED 1 Blue
    output [1:0] JA         // PMOD Header for Oscilloscope
    );

    // ==========================================
    // Problem 1: 3-Second Blinker (Mapped to LED[0])
    // ==========================================
    led_blinker p1 (
        .clk(CLK100MHZ),
        .led(LED[0])
    );

    // ==========================================
    // Problem 2: 10kHz Clock Observations (Mapped to LED[1-3] & JA)
    // ==========================================
    wire clk_10k_signal; // Wire to carry the 10kHz clock
    
    // Instance of the clock generator
    clock_10kHz p2_gen (
        .clk_100MHz(CLK100MHZ),
        .clk_10kHz(clk_10k_signal)
    );

    assign LED[1] = clk_10k_signal; // 10kHz signal
    assign LED[2] = CLK100MHZ;      // 100MHz signal (will look half bright)
    assign LED[3] = 1'b1;           // Digital High (Full bright)
    assign JA[0]  = clk_10k_signal; // Send to Pmod for Oscilloscope
    assign JA[1]  = 1'b0;           // Ground reference (optional)

    // ==========================================
    // Problem 3: Phone Number POV (Mapped to 7-Segment)
    // ==========================================
    phone_number_disp p3 (
        .clk(CLK100MHZ),
        .seg(SEG),
        .an(AN)
    );

    // ==========================================
    // Problem 4: RGB PWM (Mapped to RGB LED 16)
    // ==========================================
    // Uses Switches 0-11 to control brightness
    rgb_pwm p4 (
        .clk(CLK100MHZ),
        .sw(SW[11:0]),
        .led_r(LED16_R),
        .led_g(LED16_G),
        .led_b(LED16_B)
    );
    
    // Turn off unused LEDs
    assign LED[15:4] = 0;

endmodule