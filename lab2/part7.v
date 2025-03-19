/*part7 day clock*/
module part7 (SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, CLOCK_50 );
input CLOCK_50;
input [9:0] SW;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

reg reset, reset1, reset2;
wire clock;
wire [25:0] sec_Q;
wire [31:0] min_Q;
wire [37:0] hr_Q;
reg [5:0] sec;
reg [7:0] min;
reg [7:0] hr;
reg [7:0] set_time; //二進制

assign clk = CLOCK_50;


//define sec/min/hr counters
part7_counter sec_cr(clk, reset, sec_Q);
part7_counter1 min_cr(clk, reset1, min_Q);
part7_counter2 hr_cr(clk, reset2, hr_Q);

//SW
reg SW8_N, SW8_P, set, select;
always @(*)begin
	set = (~SW8_P) & SW8_N;
	select = SW[9];
end
always @(posedge clk)begin
	SW8_N <= SW[8];
	SW8_P <= SW8_N;
	set_time[7:0] <= SW[7:0];
end


//========== sec/min/hr counters ========
//sec_counter 0~59
always @(posedge clk)begin
	if(sec_Q == 26'd49999998)
		reset <= 1;
	else if(sec_Q >= 26'd49999999)begin
		if(sec >= 10'd59)begin
			sec <= 0;
			reset <= 0;
		end
		else begin			
			sec <= sec + 1;
			reset <= 0;
		end
	end 
	else
		reset <= 0;
end

//min_counter 0~59
always @(posedge clk)begin
	if(set && ~select && (set_time < 60))
		min <= set_time;
	else begin
		if(min_Q == 32'd2999999998)
			reset1 <= 1;
		else if(min_Q >= 32'd2999999999)begin
			if(min >= 10'd59)begin
				min <= 0;
				reset1 <= 0;
			end
			else begin			
				min <= min + 1;
				reset1 <= 0;
			end
		end 
		else
			reset1 <= 0;		
	end
end

//hr_counter 0~24
always @(posedge clk)begin

	if(hr == 23 && min == 59 && sec == 59 && sec_Q == 26'd49999999)
		hr <= 0;
	else if(min == 59 && sec == 59 && sec_Q == 26'd49999999)
		hr <= hr + 1;
	else if(set && select && (set_time < 24))
		hr <= set_time;
	else begin
		if(hr_Q == 38'd179999999998)
			reset2 <= 1;
		else if(hr_Q >= 38'd179999999999)begin
			if(hr >= 10'd24)begin
				hr <= 0;
				reset2 <= 0;
			end
			else begin			
				hr <= hr + 1;
				reset2 <= 0;
			end
		end 
		else
			reset2 <= 0;
	end
end


//==================== BCD ==========================
//BCD sec
wire [5:0] bin;
assign bin = sec;
integer i;
reg [13:0] shift_reg; 
reg [3:0]  sec_bcd_t, sec_bcd_o;

always @(*) begin
	shift_reg = {8'b0, bin}; // 初始化轉換暫存器
        for (i = 0; i < 6; i = i + 1) begin
            if (shift_reg[13:10] >= 5)
                shift_reg[13:10] = shift_reg[13:10] + 3;
            if (shift_reg[9:6] >= 5)
                shift_reg[9:6] = shift_reg[9:6] + 3;

            shift_reg = shift_reg << 1; // 左移 1 位
        end

        sec_bcd_t = shift_reg[13:10]; // 十位
        sec_bcd_o = shift_reg[9:6];  // 個位
end
//BCD min
wire [7:0] bin1;
assign bin1 = min;
integer j;
reg [13:0] shift_reg1; 
reg [3:0]  min_bcd_t, min_bcd_o;

always @(*) begin
	shift_reg1 = {6'b0, bin1}; // 初始化轉換暫存器
        for (j = 0; j < 6; j = j + 1) begin
            if (shift_reg1[13:10] >= 5)
                shift_reg1[13:10] = shift_reg1[13:10] + 3;
            if (shift_reg1[9:6] >= 5)
                shift_reg1[9:6] = shift_reg1[9:6] + 3;

            shift_reg1 = shift_reg1 << 1; // 左移 1 位
        end

        min_bcd_t = shift_reg1[13:10]; // 十位
        min_bcd_o = shift_reg1[9:6];  // 個位
end
//BCD hr
wire [7:0] bin2;
assign bin2 = hr;
integer k;
reg [12:0] shift_reg2; 
reg [3:0]  hr_bcd_t, hr_bcd_o;

always @(*) begin
	shift_reg2 = {5'b0, bin2}; // 初始化轉換暫存器
        for (k = 0; k < 5; k = k + 1) begin
            if (shift_reg2[12:9] >= 5)
                shift_reg2[12:9] = shift_reg2[12:9] + 3;
            if (shift_reg2[8:5] >= 5)
                shift_reg2[8:5] = shift_reg2[8:5] + 3;

            shift_reg2 = shift_reg2 << 1; // 左移 1 位
        end

        hr_bcd_t = shift_reg2[12:9]; // 十位
        hr_bcd_o = shift_reg2[8:5];  // 個位
end

//================ HEX5~0 =========================
//HEX0, HEX1
reg [6:0] reg_HEX0, reg_HEX1;
assign HEX0 = reg_HEX0;
assign HEX1 = reg_HEX1;

always @(*)begin
	case (sec_bcd_o)
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
	case (sec_bcd_t)
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
//HEX2, HEX3
reg [6:0] reg_HEX2, reg_HEX3;
assign HEX2 = reg_HEX2;
assign HEX3 = reg_HEX3;

always @(*)begin
	case (min_bcd_o)
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
always @(*)begin
	case (min_bcd_t)
		4'b0000: reg_HEX3 = 7'b1000000; // 0
		4'b0001: reg_HEX3 = 7'b1111001; // 1
		4'b0010: reg_HEX3 = 7'b0100100; // 2
		4'b0011: reg_HEX3 = 7'b0110000; // 3
		4'b0100: reg_HEX3 = 7'b0011001; // 4
		4'b0101: reg_HEX3 = 7'b0010010; // 5
		4'b0110: reg_HEX3 = 7'b0000010; // 6
		4'b0111: reg_HEX3 = 7'b1111000; // 7
		4'b1000: reg_HEX3 = 7'b0000000; // 8
		4'b1001: reg_HEX3 = 7'b0010000; // 9
		default: reg_HEX3 = 7'b1000000; // 0
	 endcase
end
//HEX4, HEX5
reg [6:0] reg_HEX4, reg_HEX5;
assign HEX4 = reg_HEX4;
assign HEX5 = reg_HEX5;

always @(*)begin
	case (hr_bcd_o)
		4'b0000: reg_HEX4 = 7'b1000000; // 0
		4'b0001: reg_HEX4 = 7'b1111001; // 1
		4'b0010: reg_HEX4 = 7'b0100100; // 2
		4'b0011: reg_HEX4 = 7'b0110000; // 3
		4'b0100: reg_HEX4 = 7'b0011001; // 4
		4'b0101: reg_HEX4 = 7'b0010010; // 5
		4'b0110: reg_HEX4 = 7'b0000010; // 6
		4'b0111: reg_HEX4 = 7'b1111000; // 7
		4'b1000: reg_HEX4 = 7'b0000000; // 8
		4'b1001: reg_HEX4 = 7'b0010000; // 9
		default: reg_HEX4 = 7'b1000000; // 0
	 endcase
end
always @(*)begin
	case (hr_bcd_t)
		4'b0000: reg_HEX5 = 7'b1000000; // 0
		4'b0001: reg_HEX5 = 7'b1111001; // 1
		4'b0010: reg_HEX5 = 7'b0100100; // 2
		4'b0011: reg_HEX5 = 7'b0110000; // 3
		4'b0100: reg_HEX5 = 7'b0011001; // 4
		4'b0101: reg_HEX5 = 7'b0010010; // 5
		4'b0110: reg_HEX5 = 7'b0000010; // 6
		4'b0111: reg_HEX5 = 7'b1111000; // 7
		4'b1000: reg_HEX5 = 7'b0000000; // 8
		4'b1001: reg_HEX5 = 7'b0010000; // 9
		default: reg_HEX5 = 7'b1000000; // 0
	 endcase
end


endmodule