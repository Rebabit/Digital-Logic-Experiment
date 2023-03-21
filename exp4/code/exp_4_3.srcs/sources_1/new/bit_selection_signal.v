`timescale 1ns / 1ps
module bit_selection_signal(
    input clk,rst,t_1,t_2,t_3,t_4,
    output reg [3:0]num,  
           wire [3:0]bit );
    reg [17:0]cnt;
    // ʹ��������ֵ���ʵ�ֶ�̬���������
    assign bit[0] = (!cnt[17])&&(!cnt[16]);
    assign bit[1] = (!cnt[17])&&(cnt[16]);
    assign bit[2] = (cnt[17])&&(!cnt[16]);
    assign bit[3] = (cnt[17])&&(cnt[16]);

    // cnt[17:16]����λѡ,��Ӧ4�������
    // bit[3:0]Ϊ��λλѡ�źţ�����ֻ��һ��Ϊ1����ʾ��ǰѡ����ʾ����������

    // ÿ2^16��ʱ�����ڣ���ʾ���1�������
    always @(posedge clk or negedge rst)
        begin
            if(~rst) cnt <= 18'd0;
            else cnt <= cnt +1'b1;
        end
    // ȷ����ǰ��ʾ���������ܼ���ʾ����ֵ
    always @( * )
        case(cnt[17:16])
            2'b00:num = t_4;
            2'b01:num = t_3;
            2'b10:num = t_2;
            2'b11:num = t_1;
            default:num = 4'b0000;
        endcase
endmodule