module fft_18bit_tb();

reg clk;
reg [17:0]r0,r1,r2,r3,r4,r5,r6,r7,i0,i1,i2,i3,i4,i5,i6,i7;
wire [35:0]or0,or1,or2,or3,or4,or5,or6,or7,oi0,oi1,oi2,oi3,oi4,oi5,oi6,oi7;

fft_18bit m40(clk,r0,r1,r2,r3,r4,r5,r6,r7,i0,i1,i2,i3,i4,i5,i6,i7,
        or0,or1,or2,or3,or4,or5,or6,or7,oi0,oi1,oi2,oi3,oi4,oi5,oi6,oi7);
                    
initial clk=0;
always #20 clk=~clk;
initial
begin
r0=18'h00085; i0=18'h3FF53;
r1=18'h3FF45; i1=18'h3FEFE;
r2=18'h00085; i2=18'h3FF53;
r3=18'h3FFF9; i3=18'h3FEFF;
r4=18'h3FFD6; i4=18'h3FFAE;
r5=18'h3FFF9; i5=18'h3FEFE;
r6=18'h3FFEC; i6=18'h3FFAC;
r7=18'h3FF7C; i7=18'h3FF79;
#500
r0=1; i0=0;
r1=2; i1=0;
r2=3; i2=0;
r3=4; i3=0;
r4=5; i4=0;
r5=6; i5=0;
r6=7; i6=0;
r7=8; i7=0;

#2000 $finish;

end

endmodule
