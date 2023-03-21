//����Զ��ۻ���ʱ���·����Ƴ���
`timescale 1ns / 1ps
module machine(CLK,RESET,X,Z);
    input CLK,RESET,X;
    output Z;
    reg[2:0] state,next_state;//��ǰ״̬����һ״̬
    parameter S0=3'b000,S1=3'b001,S2=3'b010,S3=3'b011,S4=3'b100;//״̬�ļ�����ֵ
    reg Z;

//�첽��·
always @(posedge CLK or posedge RESET)
begin 
    if (RESET)
        state <= S0;//��λ���ص���ʼ״̬S0�����ڳ�ʼ����
    else
        state <= next_state;//��ʱ�ӵ�������ת��״̬
end

//��һ״̬���жϣ���XΪ1��ת������һ״̬������ص���ʼ״̬
always @(X or state)
begin 
    case (state)
        S0: next_state = X ? S1 : S0;
        S1: next_state = X ? S2 : S0;
        S2: next_state = X ? S3 : S0;
        S3: next_state = X ? S4 : S0;
        S4: next_state = X ? S1 : S0;
    endcase
end

//��������ҽ�������Ͷ��4��Ӳ�ң����Ϊ1 
always @(X or state)
begin 
    case (state)
        S0: Z = 1'b0;
        S1: Z = 1'b0;
        S2: Z = 1'b0;
        S3: Z = 1'b0;
        S4: Z = 1'b1;// Moore�����
    endcase
end
endmodule
