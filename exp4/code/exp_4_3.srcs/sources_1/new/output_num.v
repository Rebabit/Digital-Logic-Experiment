`timescale 1ns / 1ps
module output_num(
    input clk,rst,
    input [29:0]cnt_1,cnt_2,cnt_3,cnt_4,
    output reg [3:0]t_1,t_2,t_3,t_4);
    
    // 十秒位 10s
    always @(posedge clk or negedge rst)
    begin
        // 复位
        if(~rst) t_1 <= 3'd0;
        // 发生进位，置为0
        else if(t_1 > 3'd5) t_1 <= 3'd0;
        // 计数器达到10^9个时钟周期后，显示数值+1
        else if(cnt_1 == 30'd9_9999_9) t_1 <= t_1 +3'd1;
    end        
	// 个秒位 1s
    always @(posedge clk or negedge rst)
    begin
        if(~rst) t_2 <= 4'd0;
        else if(t_2 > 4'd9) t_2 <= 1'd0;
        //计数器达到10^8个时钟周期后，显示数值+1
        else if(cnt_2 == 27'd9999_9) t_2 <= t_2 +4'd1;
    end     
	// 百毫秒位 0.1s
    always @(posedge clk or negedge rst)
    begin
        if(~rst) t_3 <= 4'd0;
        else if(t_3 > 4'd9) t_3 <= 1'd0;
        //计数器达到10^7个时钟周期后，显示数值+1
        else if(cnt_3 == 24'd999_9) t_3 <= t_3 +4'd1;
    end     
	// 十毫秒位 0.01s
    always @(posedge clk or negedge rst)
    begin
        if(~rst) t_4 <= 4'd0;
        else if(t_4 > 4'd9) t_4 <= 1'd0;
        //计数器达到10^6个时钟周期后，显示数值+1
        else if(cnt_4 == 20'd99_9) t_4 <= t_4 +4'd1;
    end    
endmodule