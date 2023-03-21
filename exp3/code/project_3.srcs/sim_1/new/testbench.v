//����Զ��ۻ���ʱ���·�Ĳ��Գ���
`timescale 1ns / 1ps
module testbench();
    wire Z;
    reg clock, X, reset;
    //�������У�0 10 110 1110 11110 11111
    reg[0:19] test_sequence = 20'b0_10_110_1110_11110_11111;
    //���ڱ����������еı���i
    integer i;
    //ʱ���źŵ�һ������
    parameter PERIOD = 100;
    
    machine mc(clock,reset,X,Z);
        initial
        begin
            //��ʼ��
            reset = 1'b1;
            X = 1'b0;
            #(5*PERIOD/4);
            reset = 1'b0;
            //���ղ���������������
            for (i = 0; i < 20; i = i + 1)
            begin
                X = test_sequence[i];
                //ÿ��ʱ�ӱ仯��һ�����ڣ�xȡ��һ��ֵ
                #PERIOD;
            end
                //���������н���ʱ������ģ��
                $stop;
        end

    //ʱ���źţ����ڳ���ΪPERIOD     
    always
    begin
        clock = 1'b1;
        #(PERIOD/2);
        clock = 1'b0;
        #(PERIOD/2);
    end
            
endmodule
