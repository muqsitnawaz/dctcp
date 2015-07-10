# set up new simulator
set ns [new Simulator]

#Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf

#Define a 'finish' procedure
proc finish {} {
    global ns nf
    $ns flush-trace
    #Close the NAM trace file
    close $nf
    #Execute NAM on the trace file
   	exec nam out.nam &
    exit 0
}

# creating nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

# setting nodes position
$n0 set X_ 0.0
$n0 set Y_ 0.0
$n0 set Z_ 0.0

$n1 set X_ 15.0
$n1 set Y_ 15.0
$n1 set Z_ 15.0

$n2 set X_ 30.0
$n2 set Y_ 0.0
$n2 set Z_ 0.0

$ns initial_node_pos $n0 10
$ns initial_node_pos $n1 10
$ns initial_node_pos $n2 10

#Create links between the nodes
$ns duplex-link $n0 $n1 10Mb 0.1ms DropTail
$ns duplex-link $n1 $n2 10Mb 0.1ms DropTail

#Set Queue Size of link (n2-n3) to 10
$ns queue-limit $n0 $n1 10

#Setup a TCP connection
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n2 $sink
$ns connect $tcp $sink

# ftp application
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

$ns at 0.5 "$ftp send 10"
$ns at 1.0 "$ftp stop"

#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Run the simulation
$ns run