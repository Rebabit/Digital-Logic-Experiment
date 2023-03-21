`timescale 1ns / 1ps
module shake_detect(clk,I_key,O_key);
    input clk,I_key; // I_key为接收到的按键信号
    output O_key; // 输出去抖后的稳定信号
    
    reg O_key,R_key;
    reg[16:0]cnt;
    wire change;
    parameter MAX_CNT=100;
    // 初始化
    initial
        begin
            	O_key<=0;
            	R_key<=0;
        end
    always@(posedge clk)
        begin
            R_key<=I_key;
        end
    // 记录在较短的时钟周期内是否按键信号是否发生抖动
    assign change=(I_key&!R_key)|(!I_key&R_key);
        
    always@(posedge clk)
        begin
            if(change)cnt<=0; // 发生抖动重新进行稳定计数
            else cnt<=cnt+1;
        end
    
    always@(posedge clk)
        begin
            if(cnt>MAX_CNT) // 确认稳定
                O_key<=I_key;
        end
endmodule