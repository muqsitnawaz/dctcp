set K 65

set sourceAlg DC-TCP-Sack
set switchAlg RED

set DCTCP_g_ 0.0625
set ackRatio 1
set packetSize 1460
 
set traceSamplingInterval 0.0001
set throughputSamplingInterval 0.01
set enableNAM 0

set ns [new Simulator]

Agent/TCP set ecn_ 1
Agent/TCP set old_ecn_ 1
Agent/TCP/FullTcp set segsize_ $packetSize
Agent/TCP set slow_start_restart_ false
Agent/TCP set tcpTick_ 0.01
Agent/TCP set minrto_ 0.2 ; # minRTO = 200ms
Agent/TCP set windowOption_ 0

if {[string compare $sourceAlg "DC-TCP-Sack"] == 0} {
    Agent/TCP set dctcp_ true
    Agent/TCP set dctcp_g_ $DCTCP_g_;
}
Agent/TCP/FullTcp set segsperack_ $ackRatio; 
Agent/TCP/FullTcp set spa_thresh_ 3000;
Agent/TCP/FullTcp set interval_ 0.04 ; #delayed ACK interval = 40ms

Queue set limit_ 1000

Queue/RED set bytes_ false
Queue/RED set queue_in_bytes_ true
Queue/RED set mean_pktsize_ $packetSize
Queue/RED set setbit_ true
Queue/RED set gentle_ false
Queue/RED set q_weight_ 1.0
Queue/RED set mark_p_ 1.0
Queue/RED set thresh_ [expr $K]
Queue/RED set maxthresh_ [expr $K]
			 
DelayLink set avoidReordering_ true

#Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

#Define a 'finish' procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exit 0
}

Agent/TCP instproc done {} {
	global ns starts
	
	set startTime $starts
	set endTime [$ns now]
	
	puts "Completion time form TCL: " 
	puts [expr $endTime - $startTime]
}

#Agent/TCP set windowInit_ 10

# creating nodes
set n0 [$ns node]
set n1 [$ns node]

#Create links between the nodes
$ns duplex-link $n0 $n1 5Mb 0.1ms DropTail

#Setup a TCP connection
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n1 $sink
$ns connect $tcp $sink

# ftp application
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

set starts 0
$ns at $starts "$ftp send 2500000"

#Call the finish procedure after 5 seconds of simulation time
$ns at 1000000.0 "finish"

#Run the simulation
$ns run