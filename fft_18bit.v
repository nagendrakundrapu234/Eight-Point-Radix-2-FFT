//radix 8
module radix8(clk,r0,r1,r2,r3,r4,r5,r6,r7,i0,i1,i2,i3,i4,i5,i6,i7,
                    x0,x1,x2,x3,x4,x5,x6,x7,y0,y1,y2,y3,y4,y5,y6,y7);
input clk;
input [17:0]r0,r1,r2,r3,r4,r5,r6,r7,i0,i1,i2,i3,i4,i5,i6,i7;
output reg [17:0]x0,x1,x2,x3,x4,x5,x6,x7,y0,y1,y2,y3,y4,y5,y6,y7;
always@(posedge clk)
begin
x0=r0+r4; y0=i0+i4;
x1=r1+r5; y1=i1+i5;
x2=r2+r6; y2=i2+i6;
x3=r3+r7; y3=i3+i7;
x4=r0-r4; y4=i0-i4;
x5=r1-r5; y5=i1-i5;
x6=r2-r6; y6=i2-i6;
x7=r3-r7; y7=i3-i7;

end
endmodule

// radix 4
module radix4(clk,r0,r1,r2,r3,i0,i1,i2,i3,
                    x0,x1,x2,x3,y0,y1,y2,y3);
input clk;
input [35:0]r0,r1,r2,r3,i0,i1,i2,i3;
output reg [35:0]x0,x1,x2,x3,y0,y1,y2,y3;

always@(posedge clk)
begin
x0=r0+r2; 
y0=i0+i2;

x1=r1+r3; 
y1=i1+i3;

x2=r0-r2; 
y2=i0-i2;

x3=r1-r3; 
y3=i1-i3;

end

endmodule

//radix 2
module radix2(clk,r0,r1,i0,i1,x0,x1,y0,y1);
input clk;
input [35:0]r0,r1,i0,i1;
output reg [35:0]x0,x1,y0,y1;
always@(posedge clk)
begin

x0=r0+r1; y0=i0+i1;
x1=r0-r1; y1=i0-i1;

end
endmodule

//addition
module add(clk,a,b,out);
input clk;
input [35:0]a,b;
output reg [35:0]out;
reg [36:0]x;
reg [35:0]t1=0,t2=0;
always@(posedge clk)
begin
out=a+b;
end
endmodule

//subtraction
module sub(clk,a,b,out);
input clk;
input [35:0]a,b;
output reg [35:0]out;
//reg [36:0]x;
//reg [35:0]t1=0,t2=0;
always@(posedge clk)
begin
out=a-b;
end
endmodule

//truncated multiplication
module multi_trunc(clk,a,b,out);
input clk;
input [17:0]a,b;
output reg [35:0]out=0;
//reg [17:0]t1=0,t2=0,t3=0;
reg [35:0]x=0;
//reg [1:0]ns=0;
wire [17:0]s1,s2;
assign s1=(a[17]==1)?((~a)+1):a;
assign s2=(b[17]==1)?((~b)+1):b;
//assign x=s1*s2;
always@(posedge clk)
begin
x=s1*s2;
out=x;
//out=x[17:0];
if(a[17]^b[17])
     out=(~out)+1;
else
     out=out;
end
endmodule

//fft 8 point
module fft_18bit(clk,r0,r1,r2,r3,r4,r5,r6,r7,i0,i1,i2,i3,i4,i5,i6,i7,
            or0,or1,or2,or3,or4,or5,or6,or7,oi0,oi1,oi2,oi3,oi4,oi5,oi6,oi7);
input clk;
input [17:0]r0,r1,r2,r3,r4,r5,r6,r7,i0,i1,i2,i3,i4,i5,i6,i7;
output [35:0]or0,or1,or2,or3,or4,or5,or6,or7,oi0,oi1,oi2,oi3,oi4,oi5,oi6,oi7;

wire [17:0]wr0=1000,wi0=0,wr1=707,wi1=-707,wr2=0,wi2=-1000,wr3=-707,wi3=-707; 
   //twiddle factors

wire [17:0]sr0,sr1,sr2,sr3,sr4,sr5,sr6,sr7,si0,si1,si2,si3,si4,si5,si6,si7;
wire [35:0]tr0,tr1,tr2,tr3,tr4,tr5,tr6,tr7,ti0,ti1,ti2,ti3,ti4,ti5,ti6,ti7;
wire [35:0]ur0,ur1,ur2,ur3,ur4,ur5,ur6,ur7,ui0,ui1,ui2,ui3,ui4,ui5,ui6,ui7;
wire [35:0]vr0,vr1,vr2,vr3,vi0,vi1,vi2,vi3;

wire [35:0]c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15;

// DIF
radix8 m1(clk,r0,r1,r2,r3,r4,r5,r6,r7,i0,i1,i2,i3,i4,i5,i6,i7,
            sr0,sr1,sr2,sr3,sr4,sr5,sr6,sr7,si0,si1,si2,si3,si4,si5,si6,si7);

multi_trunc m60(clk,sr0,wr0,tr4);
multi_trunc m61(clk,si0,wr0,ti4);
multi_trunc m62(clk,sr1,wr0,tr5);
multi_trunc m63(clk,si1,wr0,ti5);
multi_trunc m64(clk,sr2,wr0,tr6);
multi_trunc m65(clk,si2,wr0,ti6);
multi_trunc m66(clk,sr3,wr0,tr7);
multi_trunc m67(clk,si3,wr0,ti7);



multi_trunc m2(clk,sr4,wr0,c0);
multi_trunc m3(clk,si4,wi0,c1);
sub m41(clk,c0,c1,tr0);
multi_trunc m4(clk,si4,wr0,c2);
multi_trunc m5(clk,sr4,wi0,c3);
add m42(clk,c2,c3,ti0);

multi_trunc m6(clk,sr5,wr1,c4);
multi_trunc m7(clk,si5,wi1,c5);
sub m43(clk,c4,c5,tr1);
multi_trunc m8(clk,si5,wr1,c6);
multi_trunc m9(clk,sr5,wi1,c7);
add m44(clk,c6,c7,ti1);

multi_trunc m10(clk,sr6,wr2,c8);
multi_trunc m11(clk,si6,wi2,c9);
sub m45(clk,c8,c9,tr2);
multi_trunc m12(clk,si6,wr2,c10);
multi_trunc m13(clk,sr6,wi2,c11);
add m46(clk,c10,c11,ti2);

multi_trunc m14(clk,sr7,wr3,c12);
multi_trunc m15(clk,si7,wi3,c13);
sub m47(clk,c12,c13,tr3);
multi_trunc m16(clk,si7,wr3,c14);
multi_trunc m17(clk,sr7,wi3,c15);
add m48(clk,c14,c15,ti3);



//radix4

radix4 m19(clk,tr0,tr1,tr2,tr3,ti0,ti1,ti2,ti3,ur4,ur5,ur6,ur7,ui4,ui5,ui6,ui7);
radix4 m18(clk,tr4,tr5,tr6,tr7,ti4,ti5,ti6,ti7,ur0,ur1,ur2,ur3,ui0,ui1,ui2,ui3);


assign vr0=ur2;
assign vi0=ui2;
assign vr1=ui3;
assign vi1=-ur3;

assign vr2=ur6;
assign vi2=ui6;
assign vr3=ui7;
assign vi3=-ur7;
//radix2
radix2 m36(clk,ur0,ur1,ui0,ui1,or0,or4,oi0,oi4);
radix2 m37(clk,vr0,vr1,vi0,vi1,or2,or6,oi2,oi6);


radix2 m38(clk,ur4,ur5,ui4,ui5,or1,or5,oi1,oi5);
radix2 m39(clk,vr2,vr3,vi2,vi3,or3,or7,oi3,oi7);
endmodule
