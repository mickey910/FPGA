/*part6 3-digit BCD counter*/
module part6(CLOCK_50, KEY, HEX0, HEX1, HEX2);
input [3:0] KEY;
input CLOCK_50;
output [6:0] HEX0, HEX1, HEX2;
reg reset;
wire [25:0] Q;
reg [9:0] flash_count;

assign clk = CLOCK_50;

//define counter
part6_counter CR(clk, reset, Q);

//count
always @(posedge clk)begin//count 1 sec 0~999
	if(~KEY[0])begin
		flash_count <= 0;
		reset <= 1;
	end
	else begin
		if(Q == 26'd49999998)
			reset <= 1;
		else if(Q >= 26'd49999999)begin
			if(flash_count >= 10'd999)begin
				flash_count <= 0;
				reset <= 0;
			end
			else begin			
				flash_count <= flash_count + 1;
				reset <= 0;
			end
		end 
		else
			reset <= 0;
	end
end

//BCD 10bit to 3-digit
wire [9:0] bin;
assign bin = flash_count;
integer i;
reg [21:0] shift_reg; // 20-bit 轉換暫存器 (用於 Double Dabble)
reg [3:0] bcd_h, bcd_t, bcd_o;
//!!!
always @(*) begin
	shift_reg = {12'b0, bin}; // 初始化轉換暫存器

        for (i = 0; i < 10; i = i + 1) begin
            if (shift_reg[21:18] >= 5)
                shift_reg[21:18] = shift_reg[21:18] + 3;
            if (shift_reg[17:14] >= 5)
                shift_reg[17:14] = shift_reg[17:14] + 3;
            if (shift_reg[13:10] >= 5)
                shift_reg[13:10] = shift_reg[13:10] + 3;

            shift_reg = shift_reg << 1; // 左移 1 位
        end

        bcd_h = shift_reg[21:18]; // 百位
        bcd_t = shift_reg[17:14]; // 十位
        bcd_o = shift_reg[13:10];  // 個位
end



//HEX0, HEX1, HEX2
reg [6:0] reg_HEX0, reg_HEX1, reg_HEX2;
assign HEX0 = reg_HEX0;
assign HEX1 = reg_HEX1;
assign HEX2 = reg_HEX2;

always @(*)begin
	case (bcd_o)
		4'b0000: reg_HEX0 = 7'b1000000; // 0
		4'b0001: reg_HEX0 = 7'b1111001; // 1
		4'b0010: reg_HEX0 = 7'b0100100; // 2
		4'b0011: reg_HEX0 = 7'b0110000; // 3
		4'b0100: reg_HEX0 = 7'b0011001; // 4
		4'b0101: reg_HEX0 = 7'b0010010; // 5
		4'b0110: reg_HEX0 = 7'b0000010; // 6
		4'b0111: reg_HEX0 = 7'b1111000; // 7
		4'b1000: reg_HEX0 = 7'b0000000; // 8
		4'b1001: reg_HEX0 = 7'b0010000; // 9
		default: reg_HEX0 = 7'b1000000; // 0
	 endcase
end
always @(*)begin
	case (bcd_t)
		4'b0000: reg_HEX1 = 7'b1000000; // 0
		4'b0001: reg_HEX1 = 7'b1111001; // 1
		4'b0010: reg_HEX1 = 7'b0100100; // 2
		4'b0011: reg_HEX1 = 7'b0110000; // 3
		4'b0100: reg_HEX1 = 7'b0011001; // 4
		4'b0101: reg_HEX1 = 7'b0010010; // 5
		4'b0110: reg_HEX1 = 7'b0000010; // 6
		4'b0111: reg_HEX1 = 7'b1111000; // 7
		4'b1000: reg_HEX1 = 7'b0000000; // 8
		4'b1001: reg_HEX1 = 7'b0010000; // 9
		default: reg_HEX1 = 7'b1000000; // 0
	 endcase
end
always @(*)begin
	case (bcd_h)
		4'b0000: reg_HEX2 = 7'b1000000; // 0
		4'b0001: reg_HEX2 = 7'b1111001; // 1
		4'b0010: reg_HEX2 = 7'b0100100; // 2
		4'b0011: reg_HEX2 = 7'b0110000; // 3
		4'b0100: reg_HEX2 = 7'b0011001; // 4
		4'b0101: reg_HEX2 = 7'b0010010; // 5
		4'b0110: reg_HEX2 = 7'b0000010; // 6
		4'b0111: reg_HEX2 = 7'b1111000; // 7
		4'b1000: reg_HEX2 = 7'b0000000; // 8
		4'b1001: reg_HEX2 = 7'b0010000; // 9
		default: reg_HEX2 = 7'b1000000; // 0
	 endcase
end
endmodule