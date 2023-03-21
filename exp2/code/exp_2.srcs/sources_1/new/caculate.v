`timescale 1ns / 1ps

module calculate(X,A,B,C);
    //���룺0��15�Ķ����Ʊ�ʾ����ӦX3X2X1X0
    input wire[3:0] X;
    //�������������ƽ������3λ�����Ʊ�����Ʊ�ʾ����ӦABC
    output wire A,B,C;

    wire  
    X3_n,X2_n,X1_n,X0_n,//�������ֵķ�
    A_1,A_2,//����A��ֵ���������м����
    B_1,B_2,B_3,B_4,B_5,B_6,
    C_1,C_2,C_3,C_4,C_5,C_6;

    //���ݹ���ӳ���ĵ�·��д������Ҫ�õķ��ź������                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    not
    not3(X3_n,X[3]),//��X[3]���ӵķ���
    not2(X2_n,X[2]),//��X[2]���ӵķ���
    not1(X1_n,X[1]),//��X[1]���ӵķ���
    not0(X0_n,X[0]),//��X[0]���ӵķ���
    not3_o(A,A_2);//�����A�ķ���

    nand
    nandA_1(A_1,X0_n,X1_n),
    nandA_2(A_2,X[3],X[2],A_1),

    nandB_1(B_1,X[1],X[0]),
    nandB_2(B_2,X2_n,B_1),
    nandB_3(B_3,X3_n,B_2),
    nandB_4(B_4,X1_n,X0_n),
    nandB_5(B_5,B_4,X[2]),
    nandB_6(B_6,X[3],B_5),
    nandB_o(B,B_3,B_6),//�����B�������

    nandC_1(C_1,X1_n,X[0]),
    nandC_2(C_2,X[1],X0_n),
    nandC_3(C_3,C_1,C_2),
    nandC_4(C_4,X2_n,C_3),
    nandC_5(C_5,X[3],B_5),
    nandC_6(C_6,X3_n,X[2],X[1],X[0]),
    nandC_7(C,C_4,C_5,C_6);//�����C�������

endmodule
