`timescale 1ns / 1ps
module bit_selection_signal(
    input clk,rst,t_1,t_2,t_3,t_4,
    output reg [3:0]num,  
           wire [3:0]bit );
    reg [17:0]cnt;
    // 使用连续赋值语句实现动态点亮数码管
    assign bit[0] = (!cnt[17])&&(!cnt[16]);
    assign bit[1] = (!cnt[17])&&(cnt[16]);
    assign bit[2] = (cnt[17])&&(!cnt[16]);
    assign bit[3] = (cnt[17])&&(cnt[16]);

    // cnt[17:16]用于位选,对应4个数码管
    // bit[3:0]为四位位选信号，有且只有一个为1，表示当前选择显示输出的数码管

    // 每2^16个时钟周期，显示输出1个数码管
    always @(posedge clk or negedge rst)
        begin
            if(~rst) cnt <= 18'd0;
            else cnt <= cnt +1'b1;
        end
    // 确定当前显示输出的数码管及显示的数值
    always @( * )
        case(cnt[17:16])
            2'b00:num = t_4;
            2'b01:num = t_3;
            2'b10:num = t_2;
            2'b11:num = t_1;
            default:num = 4'b0000;
        endcase
endmodule