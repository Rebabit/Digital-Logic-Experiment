`timescale 1ns / 1ps
module output_num(
    input clk,rst,
    input [29:0]cnt_1,cnt_2,cnt_3,cnt_4,
    output reg [3:0]t_1,t_2,t_3,t_4);
    
    // ʮ��λ 10s
    always @(posedge clk or negedge rst)
    begin
        // ��λ
        if(~rst) t_1 <= 3'd0;
        // ������λ����Ϊ0
        else if(t_1 > 3'd5) t_1 <= 3'd0;
        // �������ﵽ10^9��ʱ�����ں���ʾ��ֵ+1
        else if(cnt_1 == 30'd9_9999_9) t_1 <= t_1 +3'd1;
    end        
	// ����λ 1s
    always @(posedge clk or negedge rst)
    begin
        if(~rst) t_2 <= 4'd0;
        else if(t_2 > 4'd9) t_2 <= 1'd0;
        //�������ﵽ10^8��ʱ�����ں���ʾ��ֵ+1
        else if(cnt_2 == 27'd9999_9) t_2 <= t_2 +4'd1;
    end     
	// �ٺ���λ 0.1s
    always @(posedge clk or negedge rst)
    begin
        if(~rst) t_3 <= 4'd0;
        else if(t_3 > 4'd9) t_3 <= 1'd0;
        //�������ﵽ10^7��ʱ�����ں���ʾ��ֵ+1
        else if(cnt_3 == 24'd999_9) t_3 <= t_3 +4'd1;
    end     
	// ʮ����λ 0.01s
    always @(posedge clk or negedge rst)
    begin
        if(~rst) t_4 <= 4'd0;
        else if(t_4 > 4'd9) t_4 <= 1'd0;
        //�������ﵽ10^6��ʱ�����ں���ʾ��ֵ+1
        else if(cnt_4 == 20'd99_9) t_4 <= t_4 +4'd1;
    end    
endmodule