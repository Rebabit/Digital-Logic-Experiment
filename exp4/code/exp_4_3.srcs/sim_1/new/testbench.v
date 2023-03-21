`timescale 1ns / 1ps


module testbench();
    reg CLK;
    reg rst,start,pause;
    wire overt,min1;
    wire state;
    wire [7:0] seg;
    wire [3:0]t_1,t_2,t_3,t_4;
    integer i;
    
     initial begin
       CLK <= 1'b0;
       start <= 1'b0;
       pause <= 1'b0;
       rst <= 1'b1;
   end
   
   // clock
   always #5 
   begin
       CLK=~CLK;
   end
   
   //仿真
   initial begin
        //1.开始到暂停 暂停到开始
         #100;
         start=1;
         #100000;
         #100;
         start=0;
         pause=1;
            //暂停的防抖模块
            for(i=0;i<20;i=i+1)
            begin
                #20;
                if(i%2==0)
                    pause=0;
                else
                    pause=1;
            end
         #100000;
         #100;
         pause=0;
         start=1;
         #100000;
         //开始到复位，复位到开始
         #100;
         rst=0;
         start=0;
         #100000;
         #100;
         rst=1;
         start=1;
         
         //跑到1min和超时
         for(i=0;i<20;i=i+1)
             begin
                #10000000;
             end
         
         //超时到复位
         #100;
         rst=0;
         start=0;
         #10000;
         //复位到开始
         #100;
         rst=1;
         start=1;
         #1000000;
         $stop;
   end
  
   the_config cfig
   (
        .CLK(CLK),
        .I_rst(rst),
        .I_start(start),
        .I_pause(pause),
        .overt(overt),
        .min1(min1),
        .seg(seg),
        .t_1(t_1),
        .t_2(t_2),
        .t_3(t_3),
        .t_4(t_4),
        .state(state)
   );
endmodule
