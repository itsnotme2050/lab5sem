set ns [new Simulator]
set tf [open out.tr w]
set nf [open out.nam w]

$ns trace-all $tf
$ns namtrace-all $nf

# Create nodes
	#node 0 is not a part of the lan so we create it separately
set node(0) [$ns node]

	#here we create nodes 1 to 6 and append it in a list as elements (that's what lappend does it creates a variable if there isn't already and appends the item as a element to it )
set num 6
for {set i 1} {$i <= $num} {incr i} {
set node($i) [$ns node]
lappend nodelist $node($i)
}


# create LAN and links
	#here we set up the lan for nodes for nodes 1 to 6 (note nodelist is passed as an argument)
$ns make-lan $nodelist 10Mb 10ms LL Queue/DropTail Mac/802_3 Channel
	#after setting up the lan now we set up the link for node0(separately) as it wasn't included in the lan 
$ns duplex-link $node(0) $node(1) 1Mb 10ms DropTail
$ns duplex-link-op $node(0) $node(1) queuePos 0.5	;#here we set up the queue and set the queue to 90 degrees (vertical)
$ns duplex-link-op $node(0) $node(1) orient right	;#here we change the orientation of the queue to right 


# Create connections
	#here we use tcp connection since congestion can be used in tcp protocol as its more reliable, we will have acknowledgement for every packet sent
set tcp0 [$ns create-connection TCP $node(0) TCPSink $node(5) 0]	 ;#tcp connection node(0) {source} to node(5) {destination (sink)}
set tcp1 [$ns create-connection TCP $node(2) TCPSink $node(6) 0]	 ;#tcp connection node(2) {source} to node(6) {destination (sink)}
set ftp0 [$tcp0 attach-app FTP]	;#attaching ftp to tcp connection
set ftp1 [$tcp1 attach-app FTP]	;#attaching ftp to tcp connection


#create error model for 1/1000 packets between node(0) and node(1)
set err [new ErrorModel]
$err set rate_ 0.001 ;# 0.001, 0.005, 0.010

$ns lossmodel $err $node(0) $node(1)

$tcp0 attach $tf	;#tracing the connection tcp0 on trace file tf
$tcp0 trace cwnd_	;#cwnd_ is for congestion window

$tcp1 attach $tf
$tcp1 trace cwnd_

$ns at 0.1 "$ftp0 start"
$ns at 0.2 "$ftp1 start"
$ns at 10 "finish"

proc finish {} {
global ns tf nf
$ns flush-trace
close $tf
close $nf
exit 0
}


# Start simulator
$ns run
