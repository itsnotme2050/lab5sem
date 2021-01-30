
#Author: G. Srinivasachar
#Date:
#3/6/16
#File 1.tcl
#Three nodes network & measure packets dropped
set ns [new Simulator]
set tf [open out.tr w]
set nf [open out.nam w]
$ns trace-all $tf
$ns namtrace-all $nf
# Create nodes
set num 3
for {set i 0} {$i < $num} {incr i} { set node($i) [$ns node]}
# Create links
$ns duplex-link $node(0) $node(1) 1Mb 10ms DropTail
$ns duplex-link $node(1) $node(2) 400Kb 10ms DropTail ;#800, 600, 400, 200
# Create queues 0.5*PI radians
$ns duplex-link-op $node(1) $node(2) queuePos 0.5
$ns queue-limit $node(1) $node(2) 10
# Label nodes
$node(0) label "UDP"
$node(2) label "Null"
# Label flows
$ns color 0 Red
# Create connections
set udp [$ns create-connection UDP $node(0) Null $node(2) 0]
set cbr [$udp attach-app Traffic/CBR]
# Traffic
$cbr set packetSize_ 960
$cbr set rate_ 1Mb
$cbr set interval_ 0.01 ;# choose 0.01 only; 0.001, 0.01, 0.1
$ns at 0.0 "$cbr start"
$ns at 10 "finish"
proc finish {} {
global ns tf nf
$ns flush-trace
close $tf
close $nf
exit 0
}
# Start simulation
$ns run
