`timescale 1ns / 1ps
module led(
    input clk,rst,
    input [3:0]t_1,t_2,t_3,t_4,
    output reg overt,flag1);
    reg min_1;
    always @(posedge clk or negedge rst)
    begin
        // ��λ
        if(~rst)
            begin
                flag1 <= 1'b0; // 59:99 ����1��led
                overt <= 1'b0; // 1:59:99 ����8��led
                min_1 <= 1'b0; // ��¼��ʱ��ʱ�䳬��1min
            end
        // ��ʱ�ﵽ59:99
        else if(flag1 != 1'b1 &&
                t_1 == 3'd5 && t_2 == 4'd9 && t_3 == 4'd9 && t_4 == 4'd9)
                   flag1 <= 1'b1;
        // ��ʱ�ﵽ1:00:00
        else if(flag1 == 1'b1 &&
            	t_1 == 3'd0&&t_2 == 4'd0&&t_3 == 4'd0&&t_4 == 4'd0&&flag1 == 1'b1)
           			min_1=1; 
        // ��ʱ�ﵽ1:59:99
        else if(min_1 == 1'b1 &&
                t_1 == 3'd5 && t_2 == 4'd9 && t_3 == 4'd9 && t_4 == 4'd9)
            		overt <= 7'b111_1111;
    end   
endmodule