BEGIN{
	packets_sent =0;
	packets_acks =0;
}
{
	if($1=="r" && $5=="tcp")
	{
		packets_sent++;
	}
	if($1=="r" && $5=="ack")
	{
		packets_acks++;
	}
}
END{
	printf("packets sent = %d\n",packets_sent);
	printf("packets acks = %d\n",packets_acks);
}
