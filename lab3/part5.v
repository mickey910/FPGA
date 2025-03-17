/* part5 multiplier (Array Multiplier)*/
module part5(SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY);
input [9:0] SW;
input [3:0] KEY;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

reg [7:0] regA, regB, value;
reg [15:0] regOUT;
wire [15:0] regout;
always @(*)begin
	value = SW[7:0];
	regOUT = regout;
end
always @(posedge KEY[0])begin
	if (SW[8] == 0)
		regA <= SW[7:0];
	else if(SW[8] == 1)
		regB <= SW[7:0];
end

//declare multiplier
array_multiplier_8bit multi (
	.A(regA),
	.B(regB),
	.P(regout)
);

//HEX5-4
wire [3:0] hex5,hex4;
assign hex5 = value[7:4];
assign hex4 = value[3:0];

HEX U5(hex5,HEX5);
HEX U4(hex4,HEX4);

//HEX3-0
wire [3:0] hex3,hex2, hex1,hex0;
assign hex3 = regOUT[15:12];
assign hex2 = regOUT[11:8];
assign hex1 = regOUT[7:4];
assign hex0 = regOUT[3:0];

HEX U3(hex3,HEX3);
HEX U2(hex2,HEX2);
HEX U1(hex1,HEX1);
HEX U0(hex0,HEX0);

endmodule
/*===========================================================*/
// multiplier
module array_multiplier_8bit (
    input [7:0] A, B,   // 8-bit 乘數 & 被乘數
    output [15:0] P     // 16-bit 乘積
);
    wire [7:0] pp[7:0];   // 8 行部分積
    wire [15:0] sum[6:0]; // 中間加法結果
    genvar i;
    // 產生部分積
    generate//動態產生重複的硬體結構
        for (i = 0; i < 8; i = i + 1) begin : generate_partial_products
            assign pp[i] = A & {8{B[i]}};
        end
    endgenerate
    // 累加部分積
    assign sum[0] = {8'b0, pp[0]};  // 第一行
    assign sum[1] = sum[0] + {pp[1], 1'b0};
    assign sum[2] = sum[1] + {pp[2], 2'b00};
    assign sum[3] = sum[2] + {pp[3], 3'b000};
    assign sum[4] = sum[3] + {pp[4], 4'b0000};
    assign sum[5] = sum[4] + {pp[5], 5'b00000};
    assign sum[6] = sum[5] + {pp[6], 6'b000000};
    assign P = sum[6] + {pp[7], 7'b0000000};

endmodule
module HEX (
    input [3:0] hex,   // 4-bit 十六進制輸入
    output reg [6:0] seg  // 7 段顯示器輸出（共陽極或共陰極）
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
