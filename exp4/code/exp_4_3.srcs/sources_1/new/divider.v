`timescale 1ns / 1ps

module divider(
    input clk,rst,state,
    output reg[29:0] cnt_1,cnt_2,cnt_3,cnt_4);
    parameter RESET = 2'b00,START = 2'b01,PAUSE = 2'b10,OVERTIME = 2'b11;
    
	// ʮ��λ 10s
    always @(posedge clk or negedge rst)
        begin
            // ��λ
            if(~rst)  cnt_1 <= 30'd0;
            // cnt_1�������źżǵ�10^9(10s)����㣬���¼���
            else if(cnt_1 == 30'd9_9999_9) cnt_1 <= 30'd0;
            // ��������
            else if(state ==START)  cnt_1 <= cnt_1 + 30'd1;
        end
    // ����λ 1s
    always @(posedge clk or negedge rst)
        begin
            if(~rst)  cnt_2 <= 27'd0;
            //cnt_2�������źżǵ�10^8(1s)����㣬���¼���
            else if(cnt_2 == 27'd999_99) cnt_2 <= 27'd0;
            else if(state ==START)  cnt_2 <= cnt_2 + 27'd1;
        end
    // �ٺ���λ 0.1s
    always @(posedge clk or negedge rst)
        begin
            if(~rst)  cnt_3 <= 24'd0;
            //cnt_3�������źżǵ�10^7(0.1s)����㣬���¼���
            else if(cnt_3 == 24'd999_9) cnt_3 <= 24'd0;
            else if(state ==START)  cnt_3 <= cnt_3 + 24'd1;
        end
    // ʮ����λ 0.01s
    always @(posedge clk or negedge rst)
        begin
            if(~rst)  cnt_4 <= 20'd0;
            //cnt_4�������źżǵ�10^6(0.01s)����㣬���¼���
            else if(cnt_4 == 20'd99_9) cnt_4 <= 20'd0;
            else if(state == START)  cnt_4 <= cnt_4 + 20'd1;
        end
endmodule