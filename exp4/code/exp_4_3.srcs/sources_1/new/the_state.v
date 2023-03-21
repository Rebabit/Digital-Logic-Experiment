`timescale 1ns / 1ps
module the_state(clk,rst,I_start,I_pause,overt,state);
    input clk,rst,I_start,I_pause,overt;
    output reg state;
    reg next_state;
    parameter RESET = 2'b00,START = 2'b01,PAUSE = 2'b10,OVERTIME = 2'b11;
    initial begin
        state = START;
    end
    always @(posedge clk or negedge rst)
    // ��rst���½���ʵ�ָ�λ������λ��ť�ɿ�ʱ��
    begin
        if (~rst)
            begin
                state = RESET;
            end   
        else 
        	begin
            	state = next_state;
            end
    end

    always @(posedge clk or negedge rst)
        begin
            case(state)// ���ݵ�ǰ״̬�������ź�ѡ����һ״̬
                   RESET: if(I_start)   next_state <= START;
                     	  else  next_state <= RESET;
                   START: if(I_pause)  next_state <= PAUSE;
                		  else if (overt) next_state <= OVERTIME;
                          else next_state <= START;
                   PAUSE: if(I_start)   next_state <= START;
                          else if (~rst) next_state <= RESET;
                          else next_state <= PAUSE;
                OVERTIME: if(~rst) next_state <= RESET;
                      	  else next_state <= OVERTIME;
            endcase
        end
endmodule