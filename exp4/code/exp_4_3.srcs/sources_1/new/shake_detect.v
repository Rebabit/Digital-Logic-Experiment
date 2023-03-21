`timescale 1ns / 1ps
module shake_detect(clk,I_key,O_key);
    input clk,I_key; // I_keyΪ���յ��İ����ź�
    output O_key; // ���ȥ������ȶ��ź�
    
    reg O_key,R_key;
    reg[16:0]cnt;
    wire change;
    parameter MAX_CNT=100;
    // ��ʼ��
    initial
        begin
            	O_key<=0;
            	R_key<=0;
        end
    always@(posedge clk)
        begin
            R_key<=I_key;
        end
    // ��¼�ڽ϶̵�ʱ���������Ƿ񰴼��ź��Ƿ�������
    assign change=(I_key&!R_key)|(!I_key&R_key);
        
    always@(posedge clk)
        begin
            if(change)cnt<=0; // �����������½����ȶ�����
            else cnt<=cnt+1;
        end
    
    always@(posedge clk)
        begin
            if(cnt>MAX_CNT) // ȷ���ȶ�
                O_key<=I_key;
        end
endmodule