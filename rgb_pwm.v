module rgb_pwm(
    input clk,          // 100MHz
    input [11:0] sw,    // 12 switches (4 for each color)
    output reg led_r,
    output reg led_g,
    output reg led_b
    );

    // Reuse 10kHz clock logic
    wire clk_10k;
    clock_10kHz clk_gen (.clk_100MHz(clk), .clk_10kHz(clk_10k));

    // 5-bit PWM counter (0 to 31)
    reg [4:0] pwm_ctr = 0;

    always @(posedge clk_10k) begin
        pwm_ctr <= pwm_ctr + 1;
        
        // RED Logic
        if (pwm_ctr < 16 && pwm_ctr < sw[3:0])
            led_r <= 1'b1;
        else
            led_r <= 1'b0;

        // GREEN Logic
        if (pwm_ctr < 16 && pwm_ctr < sw[7:4])
            led_g <= 1'b1;
        else
            led_g <= 1'b0;
            
        // BLUE Logic
        if (pwm_ctr < 16 && pwm_ctr < sw[11:8])
            led_b <= 1'b1;
        else
            led_b <= 1'b0;
    end
endmodule