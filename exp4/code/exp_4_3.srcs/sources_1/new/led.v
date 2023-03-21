`timescale 1ns / 1ps
module led(
    input clk,rst,
    input [3:0]t_1,t_2,t_3,t_4,
    output reg overt,flag1);
    reg min_1;
    always @(posedge clk or negedge rst)
    begin
        // 复位
        if(~rst)
            begin
                flag1 <= 1'b0; // 59:99 亮起1个led
                overt <= 1'b0; // 1:59:99 亮起8个led
                min_1 <= 1'b0; // 记录计时器时间超过1min
            end
        // 计时达到59:99
        else if(flag1 != 1'b1 &&
                t_1 == 3'd5 && t_2 == 4'd9 && t_3 == 4'd9 && t_4 == 4'd9)
                   flag1 <= 1'b1;
        // 计时达到1:00:00
        else if(flag1 == 1'b1 &&
            	t_1 == 3'd0&&t_2 == 4'd0&&t_3 == 4'd0&&t_4 == 4'd0&&flag1 == 1'b1)
           			min_1=1; 
        // 计时达到1:59:99
        else if(min_1 == 1'b1 &&
                t_1 == 3'd5 && t_2 == 4'd9 && t_3 == 4'd9 && t_4 == 4'd9)
            		overt <= 7'b111_1111;
    end   
endmodule