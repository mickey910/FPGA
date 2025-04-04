/* part2 RAM R/W 1-port M10K memory*/
module part2 (SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3);
input [9:0] SW, KEY;
output [9:0] LEDR;
output [6:0] HEX0, HEX1, HEX2, HEX3;

wire [4:0] address;
assign address = SW[8:4];
wire [3:0] datain;
assign datain = SW[3:0];
assign wren = SW[9];
assign clk = KEY[0];
wire [3:0] q;

//define RAM
ram1port r1(
	.address(address),
	.clock(clk),
	.data(datain),
	.wren(wren),
	.q(q)
);

//HEX
HEX U3(address[4], HEX3);
HEX U2(address[3:0], HEX2);
HEX U1(datain, HEX1);
HEX U0(q, HEX0);


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