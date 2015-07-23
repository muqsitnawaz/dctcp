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
   	#exec nam out.nam &
    exit 0
}

# creating nodes
set n0 [$ns node]
set n1 [$ns node]

#Create links between the nodes
$ns duplex-link $n0 $n1 100Mb 0.1ms DropTail

#Set Queue Size of link (n2-n3) to 10
$ns queue-limit $n0 $n1 10

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

$ns at 0.2 "$ftp send 1250000"

#Call the finish procedure after 5 seconds of simulation time
$ns at 12.0 "finish"

#Run the simulation
$ns run