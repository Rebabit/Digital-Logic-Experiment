`timescale 1ns / 1ps

module divider(
    input clk,rst,state,
    output reg[29:0] cnt_1,cnt_2,cnt_3,cnt_4);
    parameter RESET = 2'b00,START = 2'b01,PAUSE = 2'b10,OVERTIME = 2'b11;
    
	// 十秒位 10s
    always @(posedge clk or negedge rst)
        begin
            // 复位
            if(~rst)  cnt_1 <= 30'd0;
            // cnt_1计数器信号记到10^9(10s)后归零，重新计数
            else if(cnt_1 == 30'd9_9999_9) cnt_1 <= 30'd0;
            // 计数递增
            else if(state ==START)  cnt_1 <= cnt_1 + 30'd1;
        end
    // 个秒位 1s
    always @(posedge clk or negedge rst)
        begin
            if(~rst)  cnt_2 <= 27'd0;
            //cnt_2计数器信号记到10^8(1s)后归零，重新计数
            else if(cnt_2 == 27'd999_99) cnt_2 <= 27'd0;
            else if(state ==START)  cnt_2 <= cnt_2 + 27'd1;
        end
    // 百毫秒位 0.1s
    always @(posedge clk or negedge rst)
        begin
            if(~rst)  cnt_3 <= 24'd0;
            //cnt_3计数器信号记到10^7(0.1s)后归零，重新计数
            else if(cnt_3 == 24'd999_9) cnt_3 <= 24'd0;
            else if(state ==START)  cnt_3 <= cnt_3 + 24'd1;
        end
    // 十毫秒位 0.01s
    always @(posedge clk or negedge rst)
        begin
            if(~rst)  cnt_4 <= 20'd0;
            //cnt_4计数器信号记到10^6(0.01s)后归零，重新计数
            else if(cnt_4 == 20'd99_9) cnt_4 <= 20'd0;
            else if(state == START)  cnt_4 <= cnt_4 + 20'd1;
        end
endmodule