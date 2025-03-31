/* part5 substitute dual-port memory by single port memoryry*/
module part5 (
	input CLOCK_50,
	input [9:0] SW,
	output [9:0] LEDR,
	output [6:0] HEX0,HEX1,HEX2,HEX3
); 

assign clk = CLOCK_50;
wire [4:0] address;
assign address = SW[4:0];
wire [3:0] datain;
assign datain = SW[8:5];
assign wren = SW[9];
assign LEDR[0] = wren;
wire [3:0] q1, q2; //q1 for write, q2 for read


//define
//r1 for write
ram1port2 r1(   
    .address(a1),
    .clock(clk),
    .data(datain),
    .wren(push1),
    .q(q1)
);
//r2 for read
ram1port2 r2(
    .address(a2), //timer[4:0] for read
    .clock(clk),
    .data(q1),
    .wren(push2),
    .q(q2)
);

// wren address switch
reg wren_now, wren_past;
always @(posedge clk)begin
    wren_now <= wren;
    wren_past <= wren_now;
end
reg push1, push2;
// push1/push2
always @(*)begin 
    push1 = (wren_now & ~wren_past);
    push2 = ~push1;
end

// address
wire [4:0] a1,a2;
assign a1 = (push1)? address : timer[4:0]; //write address
assign a2 = timer[4:0]; //read address


//timer
reg [7:0] timer;
reg [25:0] clk_count;
//parameter sec = 26'd49999999;
parameter sec = 26'd29999999;
always @(posedge clk)begin
	if (timer == 8'd31 & clk_count == sec)begin
        timer <= 0;
        clk_count <= 0;
    end
	else if (clk_count == sec)begin //1sec
        clk_count <= 0;
        timer <= timer + 1;
    end
   else begin
        clk_count <= clk_count + 1;
    end      
end

//HEX
HEX U3(timer[7:4], HEX3);
HEX U2(timer[3:0], HEX2);
HEX U1(4'h0, HEX1);
HEX U0(q2, HEX0);

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