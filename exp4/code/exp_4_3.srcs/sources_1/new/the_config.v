`timescale 1ns / 1ps
module the_config(CLK,I_rst,I_start,I_pause,overt,min1,state,seg,t_1,t_2,t_3,t_4);

    input CLK;
    input I_rst,I_start,I_pause;
    output wire overt,min1;
    output wire state;
    wire O_start,O_pause,rst;
    wire [29:0]cnt_1,cnt_2,cnt_3,cnt_4;
    output wire [3:0]t_1,t_2,t_3,t_4;
    wire [3:0]num;
    wire [3:0]bit;
    output wire [7:0] seg;
    
   
    
    shake_detect start_sd
    (
        .clk(CLK),
        .I_key(I_start),
        .O_key(O_start)
    );
    shake_detect rst_sd
    (
        .clk(CLK),
        .I_key(I_rst),
        .O_key(rst)
    );
    shake_detect pause_sd
    (
        .clk(CLK),
        .I_key(I_pause),
        .O_key(O_pause)
    );
    the_state st
    (
        .clk(CLK),
        .rst(rst),
        .I_start(O_start),
        .I_pause(O_pause),
        .overt(overt),
        .state(state)
    );
    divider dv
    (
        .clk(CLK),
        .rst(rst),
        .state(state),
        .cnt_1(cnt_1),
        .cnt_2(cnt_2),
        .cnt_3(cnt_3),
        .cnt_4(cnt_4)
    );
    output_num odg
    (
        .clk(CLK),
        .rst(rst),
        .cnt_1(cnt_1),
        .cnt_2(cnt_2),
        .cnt_3(cnt_3),
        .cnt_4(cnt_4),
        .t_1(t_1),
        .t_2(t_2),
        .t_3(t_3),
        .t_4(t_4)
    );
    led ld
    (
        .clk(CLK),
        .rst(rst),
        .t_1(t_1),
        .t_2(t_2),
        .t_3(t_3),
        .t_4(t_4),
        .overt(overt),
        .flag1(min1)
    );
    bit_selection_signal bss
    (
        .clk(CLK),
        .rst(rst),
        .t_1(t_1),
        .t_2(t_2),
        .t_3(t_3),
        .t_4(t_4),
        .num(num),
        .bit(bit)
    );
    segament_selection_signal sss
    (
        .rst(rst),
        .overt(overt),
        .bin(num),
        .seg(seg)
    );
endmodule
