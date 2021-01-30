BEGIN{
cnt_1 = pkt_1 = 0;
cnt_2 = pkt_2 = 0;
}
{
if($1=="r" && $3=="_1_" && $4=="AGT")
{
cnt_1++;
pkt_1 += $8
t1 = $2;
}
if($1=="r" && $3=="_2_" && $4=="AGT")
{
cnt_2++;
pkt_2 += $8;
t2 = $2;
}
}
END{
printf("node(0) to node(1) link performance : %6.2f Mbps\n", (cnt_1*pkt_1*8)/(t1*1000000));
printf("node(1) to node(2) link performance : %6.2f Mbps\n", (cnt_2*pkt_2*8)/(t2*1000000));
}