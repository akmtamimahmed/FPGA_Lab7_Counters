module phone_number_disp(
    input clk,
    output reg [6:0] seg,   // Segments A-G
    output reg [7:0] an     // Anodes (Digit selectors)
    );

    // 1. Create a refresh strobe (scanning speed)
    // We want to scan fast enough so it doesn't flicker (approx 1kHz)
    reg [16:0] refresh_counter = 0;
    wire [2:0] digit_select;

    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;
    end
    
    // Use the top bits of the counter to select the active digit
    assign digit_select = refresh_counter[16:14]; 

    // 2. Digit Pattern Logic (Active Low Anodes typically)
    always @(*) begin
        case (digit_select)
            3'b000: an = 8'b01111111; // Digit 0 (Leftmost)
            3'b001: an = 8'b10111111; // Digit 1
            3'b010: an = 8'b11011111; // Digit 2
            3'b011: an = 8'b11101111; // Digit 3
            3'b100: an = 8'b11110111; // Digit 4
            3'b101: an = 8'b11111011; // Digit 5
            3'b110: an = 8'b11111101; // Digit 6
            3'b111: an = 8'b11111110; // Digit 7 (Rightmost)
        endcase
    end

    // 3. Number Decoder Logic (867-5309)
    // Map digit position to the number 8-6-7-5-3-0-9
    reg [3:0] number_to_display;
    always @(*) begin
        case (digit_select)
            3'b000: number_to_display = 4'd8; 
            3'b001: number_to_display = 4'd6;
            3'b010: number_to_display = 4'd7;
            3'b011: number_to_display = 4'd10; // 10 = Dash/Blank
            3'b100: number_to_display = 4'd5;
            3'b101: number_to_display = 4'd3;
            3'b110: number_to_display = 4'd0;
            3'b111: number_to_display = 4'd9;
        endcase
    end

    // 4. 7-Segment Decoder (Standard Cathode patterns)
    // 0 = on, 1 = off (Common Anode usually)
    always @(*) begin
        case (number_to_display)
            4'd0: seg = 7'b1000000; // 0
            4'd1: seg = 7'b1111001; // 1
            4'd2: seg = 7'b0100100; // 2
            4'd3: seg = 7'b0110000; // 3
            4'd4: seg = 7'b0011001; // 4
            4'd5: seg = 7'b0010010; // 5
            4'd6: seg = 7'b0000010; // 6
            4'd7: seg = 7'b1111000; // 7
            4'd8: seg = 7'b0000000; // 8
            4'd9: seg = 7'b0010000; // 9
            4'd10: seg = 7'b0111111; // Dash (-)
            default: seg = 7'b1111111; // Off
        endcase
    end
endmodule