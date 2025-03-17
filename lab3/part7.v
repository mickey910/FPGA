/*part7 multiplier 8*8 = 16*/
module part7 (KEY, SW, LEDR, HEX0, HEX1, HEX2, HEX3);
input [3:0] KEY;
input [9:0] SW;
output [9:0] LEDR;
output [6:0] HEX0, HEX1, HEX2, HEX3;

reg [7:0] regA, regB, regC, regD;
reg [31:0] reg_result;
wire [31:0] result;
wire [15:0] multi1, multi2;
wire reset, clk, select1, select2, change_dis, enable, Overflow;

assign reset = KEY[0];
assign clk = KEY[1];
assign select1 = KEY[2];
assign change_dis = KEY[3];
assign enable = SW[9];
assign select2 =  SW[8];

//assign LEDR[0] = ~reset; //reset led

always @(posedge clk or negedge reset) begin
    if (!reset) begin
        // 當 reset 為 0，立即清零（非同步）
        regA <= 0;
        regB <= 0;
        regC <= 0;
        regD <= 0;
    end else begin
        // 若 enable == 1，則更新 regA, regB, regC, regD
        if (enable) begin
            case ({select1, select2})
                2'b00: regB <= SW[7:0];
                2'b01: regD <= SW[7:0];
                2'b10: regA <= SW[7:0];
                2'b11: regC <= SW[7:0];
            endcase
        end
    end
end


//define multi and add
mult_sub mult_1(
	.dataa(regA),
	.datab(regB),
	.result(multi1)
);
mult_sub mult_2(
	.dataa(regC),
	.datab(regD),
	.result(multi2)
);

assign result = multi1 + multi2;

//display
//HEX3-0
reg [3:0] hex3,hex2, hex1,hex0;

HEX U3(hex3,HEX3);
HEX U2(hex2,HEX2);
HEX U1(hex1,HEX1);
HEX U0(hex0,HEX0);
always @(*)begin//display switch
	reg_result = result;
	if(change_dis == 0)begin //S
		hex3 = reg_result[15:12];
		hex2 = reg_result[11:8];
		hex1 = reg_result[7:4];
		hex0 = reg_result[3:0];
	end
	else 
		if(select2 == 0)begin//AB
			hex3 = regA[7:4];
			hex2 = regA[3:0];
			hex1 = regB[7:4];
			hex0 = regB[3:0];
		end
		else begin//CD
			hex3 = regC[7:4];
			hex2 = regC[3:0];
			hex1 = regD[7:4];
			hex0 = regD[3:0];
		end
end
//overflow
assign LEDR[9] = reg_result[16]; 

endmodule


/*============== submodule =============*/
module HEX (
    input [3:0] hex,   // 4-bit 十六進制輸入
    output reg [6:0] seg  // 7 段顯示器輸出
);
    always @(*) begin
        case (hex)
            4'h0: seg = 7'b1000000;  // 0
            4'h1: seg = 7'b1111001;  // 1
            4'h2: seg = 7'b0100100;  // 2
            4'h3: seg = 7'b0110000;  // 3
            4'h4: seg = 7'b0011001;  // 4
            4'h5: seg = 7'b0010010;  // 5
            4'h6: seg = 7'b0000010;  // 6
            4'h7: seg = 7'b1111000;  // 7
            4'h8: seg = 7'b0000000;  // 8
            4'h9: seg = 7'b0010000;  // 9
            4'hA: seg = 7'b0001000;  // A
            4'hB: seg = 7'b0000011;  // B
            4'hC: seg = 7'b1000110;  // C
            4'hD: seg = 7'b0100001;  // D
            4'hE: seg = 7'b0000110;  // E
            4'hF: seg = 7'b0001110;  // F
            default: seg = 7'b1000000;  // 預設關閉
        endcase
    end
endmodule