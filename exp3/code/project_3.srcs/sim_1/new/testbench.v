//针对自动售货机时序电路的测试程序
`timescale 1ns / 1ps
module testbench();
    wire Z;
    reg clock, X, reset;
    //测试序列：0 10 110 1110 11110 11111
    reg[0:19] test_sequence = 20'b0_10_110_1110_11110_11111;
    //用于遍历测试序列的变量i
    integer i;
    //时钟信号的一个周期
    parameter PERIOD = 100;
    
    machine mc(clock,reset,X,Z);
        initial
        begin
            //初始化
            reset = 1'b1;
            X = 1'b0;
            #(5*PERIOD/4);
            reset = 1'b0;
            //按照测试序列依次输入
            for (i = 0; i < 20; i = i + 1)
            begin
                X = test_sequence[i];
                //每隔时钟变化的一个周期，x取下一个值
                #PERIOD;
            end
                //在输入序列结束时，结束模拟
                $stop;
        end

    //时钟信号，周期长度为PERIOD     
    always
    begin
        clock = 1'b1;
        #(PERIOD/2);
        clock = 1'b0;
        #(PERIOD/2);
    end
            
endmodule
