# print flow function
proc printFlow {f outfile fm interval} {
	global ns
	puts $outfile [format "%d %.6f " [$f set flowid_] [expr [$f set barrivals_]*8/($interval*1000000.)] ]

	if 0 {
		set flow(0) [open "flow0" a]
		set flow(1) [open "flow1" a]
		set flow(2) [open "flow2" a]
		set flow(3) [open "flow3" a]
		set flow(4) [open "flow4" a]
		set flow(5) [open "flow5" a]
		set flow(6) [open "flow6" a]
		set flow(7) [open "flow7" a]
		set flow(8) [open "flow8" a]
		set flow(9) [open "flow9" a]
		set flow(40) [open "flow40" a]
		set flow(41) [open "flow41" a]
		set flow(42) [open "flow42" a]
		set flow(43) [open "flow43" a]
	}

	if 0 {
		if { [$f set flowid_] == 0 } {
			puts $flow(0) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
		if { [$f set flowid_] == 1 } {
			puts $flow(1) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
		if { [$f set flowid_] == 2 } {
			puts $flow(2) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
		if { [$f set flowid_] == 3 } {
			puts $flow(3) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
		if { [$f set flowid_] == 4 } {
			puts $flow(4) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
		if { [$f set flowid_] == 5 } {
			puts $flow(5) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
		if { [$f set flowid_] == 6 } {
			puts $flow(6) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
		if { [$f set flowid_] == 7 } {
			puts $flow(7) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
		if { [$f set flowid_] == 8 } {
			puts $flow(8) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
		if { [$f set flowid_] == 9 } {
			puts $flow(9) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
		if { [$f set flowid_] == 40 } {
			puts $flow(40) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
		if { [$f set flowid_] == 41 } {
			puts $flow(41) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
		if { [$f set flowid_] == 42 } {
			puts $flow(42) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
		if { [$f set flowid_] == 43 } {
			puts $flow(43) [format "%.4f %.6f" [$ns now] [expr [$f set barrivals_]*8/($interval*1000000.)] ]
		}
	}

	if 0 {
		close $flow(0)
		close $flow(1)
		close $flow(2)
		close $flow(3)
		close $flow(4)
		close $flow(5)
		close $flow(6)
		close $flow(7)
		close $flow(8)
		close $flow(9)
		close $flow(40)
		close $flow(41)
		close $flow(42)
		close $flow(43)
	}

}

# flow dump function
proc flowDump {link fm file_p interval} {
    global ns 
    $ns at [expr [$ns now] + $interval]  "flowDump $link $fm $file_p $interval"
    puts $file_p [format "Time: %.4f" [$ns now]] 
    set theflows [$fm flows]
    if {[llength $theflows] == 0} {
        return
   		} else {
           set total_arr [expr double([$fm set barrivals_])]
         if {$total_arr > 0} {
               foreach f $theflows {
                   set arr [expr [expr double([$f set barrivals_])] / $total_arr]
                   if {$arr >= 0.0001} {
                    printFlow $f $file_p $fm $interval
                }       
                $f reset
            }       
            $fm reset
        }
    }
}

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

Agent/TCP set windowInit_ 20

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

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red

#Open the NAM trace file
set nf [open out.nam w]
$ns namtrace-all $nf
set enableNam 1

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

#Create four nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

#Create links between the nodes
$ns duplex-link $n0 $n2 1000Mb 0.1ms DropTail
$ns duplex-link $n2 $n3 100Mb 0.1ms DropTail

$ns duplex-link $n1 $n2 10Mb 0.1ms DropTail


#Set Queue Size of link (n2-n3) to 10
$ns queue-limit $n2 $n3 10

#Monitor the queue for link (n2-n3). (for NAM)
$ns duplex-link-op $n2 $n3 queuePos 0.5

#Setup a TCP connection
set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink
$ns connect $tcp $sink
$tcp set fid_ 1

#Setup a FTP over TCP connection
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

# calling flow dump function
set flowlink_file "flow.trace"
set flow_file_ab [open $flowlink_file w];

set fmon [$ns makeflowmon Fid]
$fmon attach $flow_file_ab
$ns attach-fmon [$ns link $n2 $n3] $fmon 0;
$ns at 0 "flowDump [$ns link $n2 $n3] $fmon $flow_file_ab 0.08"

#Schedule events for FTP agents
$ns at 1.0 "$ftp start"
$ns at 4.0 "$ftp stop"

#Detach tcp and sink agents (not really necessary)
$ns at 4.5 "$ns detach-agent $n0 $tcp ; $ns detach-agent $n3 $sink"

#Call the finish procedure after 5 seconds of simulation time
$ns at 5.0 "finish"

#Run the simulation
$ns run