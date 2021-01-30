BEGIN{
}
{
if($6=="cwnd_")
{
if ($2 == 0 && $4 == 5) printf("%4.2f\t%4.2f\t\n",$1,$7); # $1=time, $7=cwnd size
#
if ($2 == 2 && $4 == 6) printf("%4.2f\t%4.2f\t\n",$1,$7);
}
}
