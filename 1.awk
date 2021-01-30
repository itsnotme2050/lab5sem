
#Author: G. Srinivasachar
#Date:
#3/6/16
#File 1.awk
#Count dropped packets
BEGIN {
count=0;
}
{
if($1=="d") count++;
}
END {
printf("Number of packets dropped is %d\n", count);
}
