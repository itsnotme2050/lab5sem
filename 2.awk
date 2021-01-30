BEGIN {
count=0;
}
{
if($1=="d") count++;
}
END {
printf("total no of packets dropped due to cngestion : %d\n", count);
}
